#Global Varibales
variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "tags" {
  type    = map(any)
  default = {}
}
#Network Variables

variable "ip_allocation" {
  type    = string
  default = "Dynamic"
}
variable "ip_address" {
  type = string

}
variable "sn_id" {
  type = string

}

#VM variables
variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}
variable "admin_win_username" {
  type = string
}
variable "admin_win_pass" {
  type      = string
  sensitive = true
}

variable "caching" {
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

variable "dns_servers" {
  type = list(string)
}

variable "create_option" {
  type    = string
  default = "Empty"
}

variable "stg_type" {
  type = string
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
  type = string
}

variable "storage_uri" {
  type = string
}

