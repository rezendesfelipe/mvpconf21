data "azurerm_resource_group" "server" {
  name = var.resource_group_name
}

resource "random_string" "server" {
  length  = 4
  special = false
  number  = false
}

data "azurerm_client_config" "current" {}

resource "azurerm_mysql_server" "server" {
  name                = lower(join("-", [var.server_name, random_string.server.result]))
  resource_group_name = data.azurerm_resource_group.server.name
  location            = var.location == null ? data.azurerm_resource_group.server.location : var.location

  sku_name = var.sku_name
  version  = var.server_version

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  auto_grow_enabled                 = var.auto_grow_enabled
  backup_retention_days             = var.backup_retention_days
  create_mode                       = "Default"
  geo_redundant_backup_enabled      = var.geo_redundant_backup_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  public_network_access_enabled     = var.public_network_access_enabled

  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced

  storage_mb = var.storage_mb

  tags = var.tags

  dynamic "threat_detection_policy" {
    for_each = var.threat_detection_enabled ? [1] : []
    content {
      enabled              = var.threat_detection_enabled
      disabled_alerts      = var.threat_detection_disabled_alerts
      email_account_admins = var.threat_detection_account_admins
      email_addresses      = var.threat_detection_email_addresses
      retention_days       = var.threat_detection_retention_days
    }
  }
}

resource "azurerm_mysql_configuration" "server" {
  count               = length(var.server_configurations)
  resource_group_name = data.azurerm_resource_group.server.name
  server_name         = azurerm_mysql_server.server.name
  name                = lookup(var.server_configurations[count.index], "name")
  value               = lookup(var.server_configurations[count.index], "value")
}

resource "azurerm_mysql_firewall_rule" "server" {
  count               = length(var.firewall_rules)
  resource_group_name = data.azurerm_resource_group.server.name
  server_name         = azurerm_mysql_server.server.name
  name                = lookup(var.firewall_rules[count.index], "name")
  start_ip_address    = lookup(var.firewall_rules[count.index], "start_ip_address")
  end_ip_address      = lookup(var.firewall_rules[count.index], "end_ip_address")
}

resource "azurerm_mysql_virtual_network_rule" "server" {
  count               = length(var.vnet_rules)
  resource_group_name = data.azurerm_resource_group.server.name
  server_name         = azurerm_mysql_server.server.name
  name                = lookup(var.vnet_rules[count.index], "name")
  subnet_id           = lookup(var.vnet_rules[count.index], "subnet_id")
}
