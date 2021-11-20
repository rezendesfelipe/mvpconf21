/*
 * # Azure Container Registry
 * This module presents an easy way to provision your Azure Container Registry.
*/

data "azurerm_resource_group" "acr" {
  name = var.resource_group_name
}

resource "random_string" "acr" {
  length  = 4
  special = false

}

resource "azurerm_container_registry" "acr" {
  name                = lower(join("", [var.acr_name, random_string.acr.result]))
  resource_group_name = var.resource_group_name
  location            = var.location == null ? data.azurerm_resource_group.acr.location : var.location
  sku                 = var.sku
  admin_enabled       = var.enable_admin
  tags                = var.tags
}