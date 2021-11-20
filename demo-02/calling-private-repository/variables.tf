variable "resource_group_name" {
  type    = string
  default = "rg-mvpconf"
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "tags" {
  type = any
  default = {
    env       = "demo"
    managedBy = "terraform"
  }
}

variable "vnet_name" {
  type    = string
  default = "vnet-mvpconf21"
}

variable "vnet_address_prefix" {
  type    = list(string)
  default = ["172.16.0.0/16", "192.168.0.0/24"]
}

variable "dns_servers" {
  type    = list(string)
  default = ["172.16.0.4", "172.16.0.5"]
}

variable "subnets" {
  type = any
  default = {
    subnet1 = {
      address_prefix = "172.16.0.0/24"
    }
    subnet2 = {
      address_prefix = "192.168.0.0/27"
    }
  }
}
