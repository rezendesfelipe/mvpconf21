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
  type    = string
  default = null
}

variable "priority" {
  type    = string
  default = null
}

variable "eviction_policy" {
  type    = string
  default = null
}

variable "vnet_name" {
  type    = string
  default = null
}

variable "subnet_name" {
  type    = string
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
  type    = string
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

variable "enable_accelerated_networking" {
  description = "Does this Network Interface support Accelerated Networking? Defaults to false."
  type        = bool
  default     = false
}

#Extension variables
variable "keys" {
  description = "Access Key da storage account responsavel por armazenar o Script"
  type        = any
  default     = null
}
variable "ext_name" {
  description = "Extension name"
  type        = any
  default     = null
}
variable "script_name" {
  type    = string
  default = null
}

variable "container_name" {
  type    = string
  default = null
}
variable "command_exec" {
  description = "linha de comando que irá exec o script, ex: ./prepare_vm_disks.sh"
  type        = any
  default     = null
}
variable "str_name" {
  type    = any
  default = null
}

variable "is_extension_enabled" {
  type        = bool
  default     = false
  description = "Especifica se a VM terá extensão habilitada."
}

variable "is_log_analytics_enabled" {
  type        = bool
  default     = false
  description = "Especifica se a vm terá log analytics extension habilitado"
}
variable "workspaceId" {
  type    = string
  default = null
}

variable "extension_log_name" {
  type    = string
  default = null
}
variable "workspaceKey" {
  type    = string
  default = null
}



variable "proximity_placement_group_id" {
  description = "The ID of the Proximity Placement Group which the Virtual Machine should be assigned to."
  type        = string
  default     = null
}

variable "is_boot_diagnostics_enabled" {
  type    = bool
  default = true

}
variable "boot_diagnostics" {
  type    = map(any)
  default = {}
}

variable "boot_stg" {
  type    = string
  default = null

}

variable "availability_set_id" {
  type    = string
  default = null
}
