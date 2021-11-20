resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "aks_mvpconf21" {
  source = "../../modules/aks"

  dns_name            = var.aks_dns_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  is_identity_enabled = var.aks_is_identity_enabled

  enable_log_analytics_workspace = var.aks_enable_log_analytics_workspace

  enable_attach_acr = var.aks_enable_attach_acr
  acr_id            = module.acr_mvpconf21.acr_id

  log_analytics_workspace_name    = var.aks_log_analytics_workspace_name
  enable_azure_active_directory   = var.aks_enable_azure_active_directory
  rbac_aad_managed                = var.aks_rbac_aad_managed
  rbac_aad_admin_group_object_ids = var.aks_rbac_aad_admin_group_object_ids

  vnet_name                = module.vnet_mvpconf21.vnet_name
  vnet_resource_group_name = azurerm_resource_group.rg.name
  aks_network_cidr         = var.default_aks_network_cidr
  aks_dns_ip               = var.default_aks_dns_ip
  aks_docker_bridge        = var.default_aks_docker_bridge

  k8s_version           = var.aks_k8s_version
  node_subnet           = var.aks_node_subnet
  node_vm_size          = var.aks_node_vm_size
  node_vm_disk_size     = var.aks_node_vm_disk_size
  max_pods              = var.aks_max_pods
  node_name             = var.aks_node_name
  enable_autoscaling    = var.aks_enable_autoscaling
  default_node_settings = var.aks_default_node_settings
  additional_node_pools = var.aks_additional_node_pools

  depends_on = [
    module.acr_mvpconf21,
    module.vnet_mvpconf21,
    azurerm_resource_group.rg
  ]
}

module "vnet_mvpconf21" {
  source              = "../../modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags
  vnet_name           = var.vnet_name
  address_space       = var.vnet_address_space
  subnets             = var.subnets

  vnet_peering_settings = var.vnet_peering_settings

  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "acr_mvpconf21" {
  source = "../../modules/acr"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  acr_name     = var.acr_name
  enable_admin = var.acr_enable_admin

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# Estrutura imutável de atribuição das RBACs
module "rbac_roles" {
  source                 = "../../modules/rbac"
  for_each               = local.role_assignments
  aad_group_display_name = each.key
  azurerm_access         = each.value.azurerm_access
  depends_on = [
    azurerm_resource_group.rg
  ]
}

/*
 * O Bloco local.role_assignments ajuda a facilitar e dinamizar o processo de atribuição de roles
 * Para adicionar uma nova role, basta criar uma entrada map(any) indicando o valor azurerm_access.
 * À esquerda fica o resource Id e à direita fica o DisplayName do grupo do Azure AD
*/
locals {
  role_assignments = {
    (var.developers_group_name) = {
      azurerm_access = {
        (azurerm_resource_group.rg.id) = var.developers_group_role
      }
    }
    (var._group_name) = {
      azurerm_access = {
        (azurerm_resource_group.rg.id) = var._group_role
      }
    }
  }
}
