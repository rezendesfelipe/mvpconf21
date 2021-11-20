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
