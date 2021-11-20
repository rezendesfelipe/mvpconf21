provider "azurerm" {
  features {}
}

module "nsg" {
  source              = "../terraform-cloud/modules/nsg"
  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  nsg_name            = "nsg-testing"
  tags = {
    suite       = "mvpconf21"
    produto     = "app1"
    env         = "dev"
    provisioner = "terraform"
    team        = "cloud"
  }
  rules = [
    {
      name                   = "myssh"
      priority               = 201
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "22"
      source_address_prefix  = "10.0.1.0/24"
      description            = "description-myssh"
    }
  ]
}

module "rg" {
  source   = "../terraform-cloud/modules/rg"
  location = "eastus"
  vertical = "Rafa"
  produto  = "testes"
  ambiente = "env"
  tags = {
    Owner = "rafael.veloso@softwareone.com"
  }
}

module "vnet" {
  source              = "../terraform-cloud/modules/vnet"
  vnet_name           = "vnet-test-rafa"
  resource_group_name = module.rg.rg_name
  address_space       = ["10.0.0.0/16"]
  subnets = {
    subnet1 = {
      address_prefix = "10.0.0.0/24"
    }
    subnet2 = {
      address_prefix = "10.0.1.0/24"
    }
  }
  nsg_ids = {
    subnet1 = module.nsg.nsg_id
  }

  tags = {
    Owner = "rafael.veloso@softwareone.com"
  }
  depends_on = [module.rg]
}
