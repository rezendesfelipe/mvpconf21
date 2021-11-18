#Global Varibales
variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "is_public_ip_enabled" {
  type        = bool
  default     = false
  description = "Especifica se a VM terá IP público."
}

variable "tags" {
  type    = map(any)
  default = {}
}

#Network Variables

variable "vnet_resource_group_name" {
  type = string
  default = null
}

variable "priority" {
  type = string
  default = null
}

variable "eviction_policy" {
  type = string
  default = null
}

variable "vnet_name" {
  type = string
  default = null
}

variable "subnet_name" {
  type = string
  default = null
}

variable "ip_allocation" {
  type    = string
  default = "Dynamic"
}
variable "ip_address" {
  type    = string
  default = null
}
variable "sn_id" {
  type = string
  default = null
}

#VM variables

variable "vm_name" {
  type = string
}

variable "zone" {
  type    = string
  default = null
}

variable "vm_size" {
  type = string
}
variable "admin_lnx_username" {
  type    = string
  default = "azureuser"
}
variable "caching" {
  type    = string
  default = "ReadWrite"
}

variable "stg_type" {
  type    = string
  default = "StandardSSD_LRS"
}
variable "img_publisher" {
  type = string
}
variable "img_offer" {
  type = string
}
variable "img_sku" {
  type = string
}
variable "img_version" {
  type    = string
  default = "latest"
}

variable "data_disks" {
  type    = list(any)
  default = []
}

variable "public_key" {
  type    = string
  default = null
}

variable "path_pubkey" {
  type    = string
  default = ""
}

variable "public_ip_sku" {
  description = "Defines the SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  type        = string
  default     = "Basic"
}

variable "allocation_method" {
  description = "Defines how an IP address is assigned. Options are Static or Dynamic."
  type        = string
  default     = "Static"
}