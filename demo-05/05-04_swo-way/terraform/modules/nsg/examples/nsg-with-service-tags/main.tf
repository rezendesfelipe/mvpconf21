module "nsg" {
  source              = "../terraform-cloud/modules/nsg"
  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  nsg_name            = "nsg-testing"
  tags                = var.tags
  rules = [
    {
      name                       = "deny_internet_out"
      priority                   = 201
      direction                  = "Outbound"
      destination_port_range     = "80,443"
      destination_address_prefix = "Internet"
    },
    {
      name                       = "allow_AzureCloud_in"
      priority                   = 100
      direction                  = "Inbound"
      destination_address_prefix = "AzureCloud"
    },
  ]
}
