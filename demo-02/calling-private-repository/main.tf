resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "vnet" {
  source              = "git::git@ssh.dev.azure.com:v3/swonelab/Modulos_Terraform/Modulos_Terraform//vnet?ref=feature/vnet"
                        # Azure DevOps connection -> git::git@ssh.dev.azure.com:v3/<organization>/<project>/<repositório


                        #Font: https://www.terraform.io/docs/language/modules/sources.html#modules-in-package-sub-directories
  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnet_address_prefix
  dns_servers         = var.dns_servers
  subnet              = var.subnets
  tags                = var.tags
}