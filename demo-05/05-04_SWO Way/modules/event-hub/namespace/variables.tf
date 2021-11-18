variable "resource_group_name" {
  type        = string
  description = "Nome do resource group a ser utilizado"
}

variable "name" {
  type        = string
  description = "Nome do namespace a ser criado"
}

variable "location" {
  type        = string
  description = "Localidade onde o namespace deve ser criado"
  default     = null
}

variable "sku" {
  type        = string
  description = "Define qual tier deverá ser utilizado. Suporta Basic e Standard"
  default     = "Standard"
}

variable "capacity" {
  type        = number
  description = "Especifica a capacidade/throughput units para um namespace do tier Standard"
}

variable "auto_inflate_enabled" {
  type        = bool
  description = "Especifica se o auto inflate será habilitado"
  default     = false
}

variable "dedicated_cluster_id" {
  type        = string
  description = "Especifica o id do cluster onde o namespace deve ser criado"
  default     = null
}

variable "maximum_throughput_units" {
  type        = number
  description = "Especifica o valor máximo de throughput units quando o auto inflate está habilitado. Aceite valores entre 1 e 20"
  default     = null
}

variable "zone_redundant" {
  type        = bool
  description = "Especifica se o namespace utilizará zonas de disponibilidade"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags a serem aplicadas ao recurso"
  default     = {}
}

variable "network_rulesets" {
  type = list(object({
    default_action = string
    ip_rule = list(object({
      ip_mask = string
      action  = string
    }))
    trusted_service_access_enabled = bool
    virtual_network_rule = list(object({
      ignore_missing_virtual_network_service_endpoint = bool
      subnet_id                                       = string
    }))
  }))
  default = []
}

variable "event_hubs" {
  type = list(object({
    name              = string
    partition_count   = number
    message_retention = number
  }))
  default = []
}
