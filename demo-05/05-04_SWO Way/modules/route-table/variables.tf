variable "name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "resource_group_name" {
  type = string
}

variable "routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))
}

variable "tags" {
  type    = map(any)
  default = {}
}
