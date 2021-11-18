data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_proximity_placement_group" "group" {
  name                = var.name
  location            = var.location != null ? var.location : data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = var.tags
}
