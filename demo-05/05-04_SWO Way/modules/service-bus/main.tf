data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}

resource "azurerm_servicebus_namespace" "example" {
  name                = var.namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  sku                 = var.sku_name
}
