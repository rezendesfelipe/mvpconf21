variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "cdn_profile_name" {
  type        = string
  description = "Nome do perfil do CDN"
}

variable "sku" {
  type        = string
  description = "Qual SKU será usada por este perfil de CDN. Valores aceitos Standard_Akamai, Standard_ChinaCdn, Standard_Microsoft, Standard_Verizon or Premium_Verizon"
  default     = "Standard_Microsoft"
}

variable "cdn_endpoint_name" {
  type    = list(string)
  default = null
}

variable "cdn_origin_hostname" {
  type    = list(string)
  default = null
}

variable "cdn_origin_path" {
  type    = list(string)
  default = []
}

variable "cdn_caching_behavior" {
  type    = list(string)
  default = ["IgnoreQueryString"]
}

variable "content_types_to_compress" {
  type    = list(string)
  default = []
}

variable "cdn_endpoint" {
  type = map(
    object(
      {
        endpoint_name       = string
        cdn_origin_hostname = string
        cdn_origin_path     = string
      }
    )
  )
  default = {}
}

variable "origin" {
  description = "Origin Definition and URL."
  type        = map(any)
  default     = {}
}
