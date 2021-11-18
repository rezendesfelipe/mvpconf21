#Global Varibales
variable "resource_group_name" {
  type = string
}

#variable "image_resource_group_name" {
#  type = string
#  description = "Shared Image Gallery Resource Group."
#}
variable "location" {
  type    = string
  default = "eastus2"
}
variable "tags" {
  type    = map(any)
  default = {}
}
variable "virtual_network_name" {
  description = "The name of the virtual network"
  default     = ""
}
variable "subnet_names" {
  description = "The name of the subnet to use in VM scale set"
  default     = []
}
variable "nsg_inbound_rules" {
  description = "List of network rules to apply to network interface."
  default     = []
}
variable "ip_allocation" {
  type    = string
  default = "Dynamic"
}

variable "path_pubkey" {
  type    = string
  default = ""
}
variable "ip_address" {
  type    = string
  default = null
}
variable "sn_id" {
  type = string
}
variable "image_reference_id" {
  type    = string
  default = "/subscriptions/74b0c47d-f13e-4931-b415-f4f0dea7d409/resourceGroups/rg-commerce-gallery/providers/Microsoft.Compute/galleries/commerce_gallery/images/template_websrv/versions/0.0.1"
}
variable "image_id" {
  type = string
}
variable "vm_name" {
  type = string
}
variable "vm_size" {
  type = string
}
variable "disk_size_gb" {
  type    = number
  default = 32
}

variable "lun" {
  type    = number
  default = 0
}

variable "caching" {
  type    = string
  default = "ReadWrite"
}
variable "stg_type" {
  type    = string
  default = "StandardSSD_LRS"
}
variable "admin_win_username" {
  type = string
}
variable "admin_win_pass" {
  type      = string
  sensitive = true
}

#variable "image_name" {
#  type    = string
#}
#variable "gallery_name" {
#    type   = string
#}

variable "os_flavor" {
  type    = string
  default = "windows"
}

variable "dns_servers" {
  type = list(string)
}

variable "storage_uri" {
  type = string
}

#-------------------------
# Public IP Variables
#-------------------------

#-------------------------
# Novos Public Ips
#-------------------------
variable "is_public_ip_enabled" {
  type    = bool
  default = false
}

variable "allocation_method" {
  type    = string
  default = "Static"
}

variable "public_ip_sku" {
  type    = string
  default = "Basic"
}

#-------------------------
# Public Ips existentes
#-------------------------

variable "existing_public_ip" {
  type    = bool
  default = false
}

variable "public_ip_id" {
  type    = string
  default = null
}
