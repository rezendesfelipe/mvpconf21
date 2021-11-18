resource "azurerm_resource_group" "rg" {
  name     = lower("rg-${var.vertical}-${var.produto}-${var.ambiente}")
  location = var.location
  tags     = var.tags
}