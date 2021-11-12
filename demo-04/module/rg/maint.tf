resource "azurerm_resource_group" "rg" {
  name     = lower(join("-", ["rg", var.resource_group_name]))
  location = var.location
  tags     = var.tags
}