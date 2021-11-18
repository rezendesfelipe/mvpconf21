data "azurerm_resource_group" "server" {
  name = var.resource_group_name
}

resource "random_string" "db" {
  length  = 4
  special = false
  number  = false
}

resource "azurerm_cosmosdb_account" "db" {
  name                = lower(join("-", [var.db_name, random_string.db.result]))
  resource_group_name = data.azurerm_resource_group.server.name
  location            = var.location == null ? data.azurerm_resource_group.server.location : var.location
  offer_type          = "Standard"
  kind                = var.kind

  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = var.max_interval_in_seconds
    max_staleness_prefix    = var.max_staleness_prefix
  }

  dynamic "geo_location" {
    for_each = toset(var.geo_locations)
    content {
      location          = geo_location.value["location"]
      failover_priority = geo_location.value["failover_priority"]
      zone_redundant    = geo_location.value["zone_redundant"]
    }
  }

  ip_range_filter               = var.ip_range_filter
  enable_free_tier              = var.enable_free_tier
  analytical_storage_enabled    = var.analytical_storage_enabled
  enable_automatic_failover     = var.enable_automatic_failover
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "capabilities" {
    for_each = toset(var.capabilities)
    content {
      name = capabilities.value
    }
  }

  is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled

  dynamic "virtual_network_rule" {
    for_each = toset(var.virtual_network_rules)
    content {
      id                                   = virtual_network_rule.value["id"]
      ignore_missing_vnet_service_endpoint = virtual_network_rule.value["ignore_missing_vnet_service_endpoint"]
    }
  }

  tags = var.tags

}
