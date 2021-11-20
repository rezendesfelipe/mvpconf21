module "nsg" {
  source              = "../terraform-cloud/modules/nsg"
  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  nsg_name            = "nsg-testing"
  tags                = var.tags
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
