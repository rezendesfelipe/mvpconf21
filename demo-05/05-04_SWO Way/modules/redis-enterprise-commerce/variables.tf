variable "name" {
  type        = string
  description = "Name of the resource."
  default     = ""
}

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}

variable "sku_name" {
  description = "Redis Cache Sku name. Can be Basic, Standard or Premium"
  type        = string
}

variable "enable_non_ssl_port" {
  description = "A map of enable_non_ssl_port"
  type        = bool
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "subnet_id" {
  description = "Only available when using the Premium SKU, The ID of the Subnet within which the Redis Cache should be deployed.This Subnet must only contain Azure Cache for Redis instances without any other type of resources. Changing this forces a new resource to be created."
  type        = string
  default     = null
}