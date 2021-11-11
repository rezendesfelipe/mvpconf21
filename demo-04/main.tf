resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "vnet" {
  source              = "./module/vnet"
  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnet_address_prefix
  dns_servers         = var.dns_servers
  subnet              = var.subnets
  tags                = var.tags
}

module "nsg" {
  source = "./module/nsg"
  
}