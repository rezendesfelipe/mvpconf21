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

  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  nsg_name            = "nsg-testing"
  tags                = vartags
  rules = [
    {
      name                   = "allow_ssh_in"
      priority               = 201
      direction              = "Inbound"
      destination_port_range = "22"
      source_address_prefix  = "10.0.1.0/24"
      description            = "description-myssh"
    },
  ]
}