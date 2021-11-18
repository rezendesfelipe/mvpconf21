variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group."
}

variable "vnet_resource_group_name" {
  type        = string
  description = "Nome do Resource Group da Virtual Network."
}

variable "vnet_name" {
  type        = string
  description = "Nome da Virtual Network a ser utilizada."
}

variable "subnet_name" {
  type        = string
  description = "Nome da Subnet a ser utilizada."
}

variable "name" {
  type        = string
  description = "Nome do Load Balancer."
}

variable "location" {
  type        = string
  description = "Localização a ser utilizada."
}

variable "sku" {
  type        = string
  description = "SKU a ser utilizada. Aceita Basic e Standard."
  default     = "Basic"
}

variable "is_public_ip_enabled" {
  type        = bool
  description = "Especifica se o Load Balancer terá IP público."
}

variable "frontends" {
  type = list(object({
    name                          = string
    private_ip_address_allocation = string
    private_ip_address            = string
  }))
  description = "Lista de configurações de frontend."
}

variable "tags" {
  type        = map(any)
  description = "Tags a serem aplicadas."
  default     = {}
}

variable "backends" {
  type = list(object({
    name         = string
    ip_addresses = list(string)
  }))
  description = "Lista de backend pools."
  default     = []
}

variable "probes" {
  type = list(object({
    name                = string
    protocol            = string
    port                = number
    request_path        = string
    interval_in_seconds = number
    number_of_probes    = number
  }))
  description = "Lista de probes."
  default     = []
}

variable "rules" {
  type = list(object({
    name                    = string
    frontend_name           = string
    backend_pool_name       = string
    probe_name              = string
    protocol                = string
    frontend_port           = number
    backend_port            = number
    enable_floating_ip      = bool
    idle_timeout_in_minutes = number
    load_distribution       = string
    disable_outbound_snat   = bool
    enable_tcp_reset        = bool
  }))
  description = "Lista de routing rules."
  default     = []
}
