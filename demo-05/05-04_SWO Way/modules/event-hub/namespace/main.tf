data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "random_string" "random" {
  length  = 4
  special = false
  number  = false
}

resource "azurerm_eventhub_namespace" "ns" {
  name                 = lower(join("-", [var.name, random_string.random.result]))
  resource_group_name  = data.azurerm_resource_group.rg.name
  location             = var.location != null ? var.location : data.azurerm_resource_group.rg.location
  sku                  = var.sku
  capacity             = var.capacity
  auto_inflate_enabled = var.auto_inflate_enabled
  dedicated_cluster_id = var.dedicated_cluster_id

  identity {
    type = "SystemAssigned"
  }

  maximum_throughput_units = var.maximum_throughput_units
  zone_redundant           = var.zone_redundant
  tags                     = var.tags
  network_rulesets         = var.network_rulesets
}

resource "azurerm_eventhub" "event_hub" {
  for_each            = { for item in var.event_hubs : item.name => item }
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.rg.name
  namespace_name      = azurerm_eventhub_namespace.ns.name
  partition_count     = each.value.partition_count
  message_retention   = each.value.message_retention
}
