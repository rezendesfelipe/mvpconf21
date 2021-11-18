variable "name" {
  type        = string
  description = "Name of the resource."
  default     = ""
}

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}

variable "capacity" {
  description = "Redis size: (Basic/Standard: 1,2,3,4,5,6) (Premium: 1,2,3,4)  https://docs.microsoft.com/fr-fr/azure/redis-cache/cache-how-to-premium-clustering"
  type        = number
}

variable "sku_name" {
  description = "Redis Cache Sku name. Can be Basic, Standard or Premium"
  type        = string
}

variable "enable_non_ssl_port" {
  description = "A map of enable_non_ssl_port"
  type        = bool
}

variable "shard_count" {
  description = "Number of cluster shards desired"
  type        = number
}

variable "minimum_tls_version" {
  description = "The minimum TLS version"
  type        = string
}

variable "private_static_ip_address" {
  description = "The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. Changing this forces a new resource to be created. "
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Only available when using the Premium SKU, The ID of the Subnet within which the Redis Cache should be deployed.This Subnet must only contain Azure Cache for Redis instances without any other type of resources. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "enable_authentication" {
  type    = bool
  default = true
}

variable "is_public_network_access_enabled" {
  type    = bool
  default = null
}

variable "is_endpoint_enabled" {
  type    = bool
  default = false
}

variable "firewall_rules" {
  type = list(object({
    name     = string
    start_ip = string
    end_ip   = string
  }))
  default = []
}
