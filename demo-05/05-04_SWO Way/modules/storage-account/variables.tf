variable "storage_account_name" {
  type = string
}

variable "location" {
  type    = string
  default = null
}

variable "resource_group_name" {
  type = string
}

variable "tier" {
  type    = string
  default = "Standard"
}

variable "kind" {
  type    = string
  default = "StorageV2"
}

variable "replication" {
  type    = string
  default = "GRS"
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "static_website_enabled" {
  type    = bool
  default = false
}

variable "static_website" {
  type    = map(any)
  default = {}
}
variable "storacc_containers" {
  type = map(object({
    name                  = string
    container_access_type = string
  }))
  default = {}
}