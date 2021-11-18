variable "resource_group_name" {
  type    = string
  default = "rg-mvpconf21-prd"
}
variable "location" {
  type    = string
  default = "eastus2"
}

variable "tags" {
  type = map(any)
  default = {

  }
}

variable "app_id" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

variable "public_key" {
  type    = string
  default = null
}
