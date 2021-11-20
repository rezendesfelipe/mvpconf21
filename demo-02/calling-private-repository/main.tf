resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "vnet" {
  source = "git::git@github.com:rezendesfelipe/mvpconf21.git//demo-02/private-module-repository/vnet?ref=main"
  # Azure DevOps connection -> git::git@ssh.dev.azure.com:v3/<organization>/<project>.git//path/to/mdule?ref=<tag or branch>


  #Font: https://www.terraform.io/docs/language/modules/sources.html#modules-in-package-sub-directories
  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnet_address_prefix
  dns_servers         = var.dns_servers
  subnet              = var.subnets
  tags                = var.tags
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "network-security-group" {
  source  = "app.terraform.io/SWOCloudServices/network-security-group/azurerm"
  version = "1.0.0"
  # insert required variables here
  nsg_name            = "nsg-mvpconf"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags
  depends_on = [
    azurerm_resource_group.rg
  ]
}

