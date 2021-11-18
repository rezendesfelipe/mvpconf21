variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "acr_name" {
  type    = string
  default = "acr"
}

variable "sku" {
  type    = string
  default = "Standard"
  validation {
    condition     = can(regex("Standard|Premium|Basic", var.sku))
    error_message = "Selecione apenas um dos valores aceitos como SKU: Basic, Standard, ou Premium."
  }
}

variable "enable_admin" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(any)
  default = {}
}