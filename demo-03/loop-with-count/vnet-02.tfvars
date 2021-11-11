location            = "eastus2"
resource_group_name = "rg-vnet-with-count"
subnet_address_prefixes = [
  "10.0.0.0/24", #0
  "10.0.2.0/24"  #1
]
subnet_names = [
  "Subnet1", #0
  "Subnet3"  #1
]
tags = {
  event       = "mvpconf2021"
  environment = "demo"
  createdBy   = "@carlosdoliveira"
}
vnet_address_space = ["10.0.0.0/16"]
vnet_name          = "vnet-with-count"
