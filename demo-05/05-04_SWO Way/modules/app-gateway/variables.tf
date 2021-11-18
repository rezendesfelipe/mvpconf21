variable "resource_group_name" {
  type = string
}

variable "vnet_resource_group_name" {
  type = string
}

variable "appgw_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "sku" {
  type = string
}

variable "tier" {
  type    = string
  default = "Standard"
}

variable "capacity" {
  type        = number
  description = "The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set."
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "ip_sku" {
  type    = string
  default = "Static"
}

variable "is_public_ip_enabled" {
  type        = bool
  default     = true
  description = "Especifica se o Application Gateway terá IP público."
}

variable "gateway_ip_configurations" {
  type        = list(string)
  default     = ["appGwPublicFrontendIp", "appGwPrivateFrontendIp"]
  description = "Nome das configurações de frontend."
}

variable "frontend_ports" {
  type = list(object({
    name = string
    port = number
  }))
}

variable "frontends" {
  type = list(object({
    name                 = string
    is_public_ip_enabled = bool
    private_ip_address   = string
  }))
}

variable "http_listener" {
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    ssl_certificate_name           = string
    protocol                       = string
    host_name                      = string
    require_sni                    = string
  }))
}

variable "probes" {
  type = list(object({
    name                                      = string
    host                                      = string
    interval                                  = number
    path                                      = string
    protocol                                  = string
    timeout                                   = number
    unhealthy_threshold                       = number
    pick_host_name_from_backend_http_settings = bool
  }))
}

variable "rules" {
  type = list(object({
    name                        = string
    rule_type                   = string
    http_listener_name          = string
    backend_address_pool_name   = string
    backend_http_settings_name  = string
    redirect_configuration_name = string
    url_path_map_name           = string
  }))
}

variable "ssl_certificate" {
  type = list(object({
    name                = string
    key_vault_secret_id = string
  }))
}

variable "url_path_map" {
  type = list(object({
    name                                = string
    default_backend_address_pool_name   = string
    default_backend_http_settings_name  = string
    default_redirect_configuration_name = string
    path_rules = list(object({
      name                        = string
      paths                       = list(string)
      backend_address_pool_name   = string
      backend_http_settings_name  = string
      redirect_configuration_name = string
    }))
  }))
}

variable "location" {
  type    = string
  default = null
}

variable "backend_address_pool" {
  type = list(string)
}

variable "backend_http_settings" {
  type = list(object({
    name                                = string
    cookie_based_affinity               = string
    affinity_cookie_name                = string
    path                                = string
    port                                = number
    probe_name                          = string
    protocol                            = string
    request_timeout                     = number
    host_name                           = string
    pick_host_name_from_backend_address = bool
  }))
}

variable "redirect_configurations" {
  type = list(object({
    name                 = string
    redirect_type        = string
    target_listener_name = string
    target_url           = string
    include_path         = bool
    include_query_string = bool
  }))
}

variable "is_autoscale_enabled" {
  type    = bool
  default = false
}

variable "autoscale_min_capacity" {
  type    = number
  default = null
}

variable "autoscale_max_capacity" {
  type    = number
  default = null
}
