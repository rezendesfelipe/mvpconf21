/*
  * # Azure Kubernetes Services
  * Este material apresenta o módulo do Azure Kubernetes Services e suas entradas necessárias.
*/

# RG que será usado pelo AKS
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# RG da Virtual Network
data "azurerm_resource_group" "vnet" {
  name = var.vnet_resource_group_name
}

data "azurerm_virtual_network" "aks" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.vnet.name
}

data "azurerm_subnet" "aks_node" {
  name                 = var.node_subnet
  resource_group_name  = data.azurerm_resource_group.vnet.name
  virtual_network_name = data.azurerm_virtual_network.aks.name
}

locals {
  dns_name = join("-", [var.dns_name, random_string.aks.result])
  #dns_prefix = join ("", [var.dns_name, random_string.aks.result]) # Esta lógica permite que um nome aleatório seja garantido na hora de criar o nome do cluster e do DNS.
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                    = local.dns_name
  location                = var.location == null ? data.azurerm_resource_group.rg.location : var.location
  resource_group_name     = data.azurerm_resource_group.rg.name
  private_cluster_enabled = var.is_private_cluster_enabled
  dns_prefix              = local.dns_name
  kubernetes_version      = var.k8s_version
  default_node_pool {

    name                   = var.node_name
    enable_auto_scaling    = var.enable_autoscaling
    node_count             = lookup(var.default_node_settings, "node_count", var.node_vm_count)
    max_count              = var.enable_autoscaling == true ? lookup(var.default_node_settings, "max_count", null) : null
    min_count              = var.enable_autoscaling == true ? lookup(var.default_node_settings, "min_count", null) : null
    vm_size                = var.node_vm_size
    enable_host_encryption = var.host_encryption
    os_disk_size_gb        = var.node_vm_disk_size
    vnet_subnet_id         = data.azurerm_subnet.aks_node.id
    availability_zones     = var.node_av_zone

  }

  dynamic "service_principal" {
    for_each = var.is_identity_enabled ? [] : [1]
    content {
      client_id     = var.app_id
      client_secret = var.password
    }
  }

  dynamic "identity" {
    for_each = var.is_identity_enabled ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  role_based_access_control {
    enabled = var.enable_role_based_access_control

    dynamic "azure_active_directory" {
      for_each = var.enable_role_based_access_control && var.enable_azure_active_directory && var.rbac_aad_managed ? ["rbac"] : []
      content {
        managed                = true
        admin_group_object_ids = var.rbac_aad_admin_group_object_ids
      }
    }
  }
  addon_profile {
    azure_policy {
      enabled = var.enable_azure_policy
    }

    http_application_routing {
      enabled = var.enable_http_application_routing
    }
    oms_agent {
      enabled                    = var.enable_log_analytics_workspace ? true : false
      log_analytics_workspace_id = var.enable_log_analytics_workspace ? azurerm_log_analytics_workspace.aks_wksp[0].id : null
    }
  }

  tags = var.tags
  network_profile {
    network_plugin     = var.aks_network_plugin
    network_policy     = var.aks_network_policy
    service_cidr       = var.aks_network_cidr
    docker_bridge_cidr = var.aks_docker_bridge
    dns_service_ip     = var.aks_dns_ip
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "aks" {
  lifecycle {
    ignore_changes = [
      node_count
    ]
  }

  for_each = var.additional_node_pools

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = each.value.additional_node_name #each.value.node_os == "linux" ? substr(each.key, 0, 6) : substr(each.key, 0, 12)
  orchestrator_version  = var.k8s_version
  node_count            = each.value.node_count
  vm_size               = each.value.vm_size
  availability_zones    = each.value.zones
  max_pods              = each.value.max_pods != null ? each.value.max_pods : 60
  os_disk_size_gb       = each.value.os_disk_size
  os_type               = each.value.node_os
  vnet_subnet_id        = data.azurerm_subnet.aks_node.id
  enable_auto_scaling   = each.value.cluster_auto_scaling
  min_count             = each.value.cluster_auto_scaling_min_count
  max_count             = each.value.cluster_auto_scaling_max_count
  enable_node_public_ip = each.value.enable_public_ip
  tags                  = var.tags
}

resource "azurerm_role_assignment" "attach_acr" {
  count = var.enable_attach_acr ? 1 : 0

  scope                            = var.acr_id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "aks" {
  count = var.enable_log_analytics_workspace ? 1 : 0

  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_kubernetes_cluster.aks.addon_profile[0].oms_agent[0].oms_agent_identity[0].object_id
}

resource "random_string" "aks" {
  special = false
  lower   = true
  upper   = false
  length  = 4
}

resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "aks_wksp" {
  count = var.enable_log_analytics_workspace ? 1 : 0
  # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
  name                = join("-", [var.log_analytics_workspace_name, random_id.log_analytics_workspace_name_suffix.dec])
  location            = var.location == null ? data.azurerm_resource_group.rg.location : var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_retention_in_days
}

resource "azurerm_log_analytics_solution" "aks_analytics" {
  count                 = var.enable_log_analytics_workspace ? 1 : 0
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.aks_wksp[0].location
  resource_group_name   = data.azurerm_resource_group.rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.aks_wksp[0].id
  workspace_name        = azurerm_log_analytics_workspace.aks_wksp[0].name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}