data "azurerm_resource_group" "kv" {
  name = var.resource_group_name
}

data "azurerm_client_config" "current" {}

resource "random_string" "random" {
  length  = 4
  special = false
  number  = false
}

resource "azurerm_key_vault" "kv" {
  name                            = lower(join("-", [var.kv_name, random_string.random.result]))
  resource_group_name             = data.azurerm_resource_group.kv.name
  location                        = var.location == null ? data.azurerm_resource_group.kv.location : var.location
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enable_rbac_authorization       = var.enable_rbac_authorization
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.sku_name
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days
  tags                            = var.tags

  network_acls {
    bypass                     = var.network_acls_bypass
    default_action             = var.network_acls_default_action
    ip_rules                   = var.network_acls_ip_rules
    virtual_network_subnet_ids = var.network_acls_virtual_network_subnet_ids
  }

}

resource "azurerm_key_vault_access_policy" "access_policy" {
  count                   = length(var.access_policies)
  key_vault_id            = azurerm_key_vault.kv.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = lookup(var.access_policies[count.index], "object_id")
  application_id          = lookup(var.access_policies[count.index], "application_id", null)
  key_permissions         = lookup(var.access_policies[count.index], "key_permissions")
  secret_permissions      = lookup(var.access_policies[count.index], "secret_permissions")
  certificate_permissions = lookup(var.access_policies[count.index], "certificate_permissions")
  storage_permissions     = lookup(var.access_policies[count.index], "storage_permissions")
}
