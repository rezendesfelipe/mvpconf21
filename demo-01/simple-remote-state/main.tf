provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "test"
  location = "eastus2"
}
