# RG que será usado pelo AKS
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# RG da Virtual Network
data "azurerm_resource_group" "vnet" {
  name = var.vnet_resource_group_name
}


resource "random_string" "aks" {
  special = false
  lower   = true
  upper   = false
  length  = 4
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
  dns_name = join("-", [var.dns_name, random_string.aks.result]) # Esta lógica permite que um nome aleatório seja garantido na hora de criar o nome do cluster e do DNS.
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.dns_name
  location            = var.location == null ? data.azurerm_resource_group.rg.location : var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = local.dns_name
  kubernetes_version  = var.k8s_version
  default_node_pool {

    name                = var.node_name
    enable_auto_scaling = var.enable_autoscaling
    node_count          = lookup(var.default_node_settings, "node_count", var.node_vm_count)
    max_count           = var.enable_autoscaling == true ? lookup(var.default_node_settings, "max_count", null) : null
    min_count           = var.enable_autoscaling == true ? lookup(var.default_node_settings, "min_count", null) : null
    vm_size             = var.node_vm_size
    os_disk_size_gb     = var.node_vm_disk_size
    vnet_subnet_id      = data.azurerm_subnet.aks_node.id
    availability_zones  = var.node_av_zone

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
    enabled = true
  }

  tags = var.tags
  network_profile {
    network_plugin     = "azure"
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
  name                  = each.value.node_os == "Windows" ? substr(each.key, 0, 6) : substr(each.key, 0, 12)
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
