location            = "eastus2"
resource_group_name = "rg-vnet-with-count"
subnets = {
  subnet1 = {
    address_prefix = "10.0.0.0/24"
  }

  subnet2 = {
    address_prefix = "10.0.1.0/24"
  }

  subnet3 = {
    address_prefix = "10.0.2.0/24"
  }

}
tags = {
  event       = "mvpconf2021"
  environment = "demo"
  createdBy   = "@carlosdoliveira"
}

vnet_address_space = ["10.0.0.0/16"]
vnet_name          = "vnet-with-foreach"
