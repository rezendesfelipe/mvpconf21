data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_eventhub_cluster" "cluster" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location != null ? var.location : data.azurerm_resource_group.rg.location
  sku_name            = "Dedicated_1"
  tags                = var.tags
}
