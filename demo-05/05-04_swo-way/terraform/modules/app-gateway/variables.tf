#----------------------
# Global Variables
#----------------------

variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group do Application Gateway."
}


variable "location" {
  type        = string
  description = "Localização dos recursos a serem provisionados e localizados."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de tags para os recursos."
}

#----------------------
# Vnet Variables
#----------------------

variable "vnet_resource_group_name" {
  type        = string
  description = "Nome do Resource Group da Rede Virtual."
}

variable "vnet_name" {
  type        = string
  description = "Nome da Rede Virtual a ser localizada."
}

variable "subnet_name" {
  type        = string
  description = "Nome da subnet para inserir o Application Gateway."
}

#----------------------
# App Gateway Variables
#----------------------

variable "appgw_name" {
  type        = string
  description = "Nome do Application Gateway."
}

variable "sku" {
  type        = string
  default     = "Standard_v2"
  description = "SKU do Application Gateway. Aceita valores como `Standard_Small`, `Standard_Medium`, `Standard_Large`, `WAF_Medium` e `WAF_Large` para SKU v1 e `Standard_v2` e `WAF_v2` para SKU v2."
}

variable "tier" {
  type        = string
  default     = "Standard_v2"
  description = "Define qual o tier do Application Gateway. Aceita valores como: `Standard` e `WAF` para SKU v1 e  `Standard_v2` ou `WAF_v2` para SKU v2."
}

variable "capacity" {
  type        = number
  default     = 2
  description = "A configuração de capacidade da SKU a ser usada pelo Application Gateway. Quando estiver usando uma SKU v1 este valor precisa ser entre `1` e `32`, e quando for uma SKU v2 precisa ser entre `1` to `125`. Esta propriedade é opcional se a variavel `is_autoscale_enabled` está marcada como `true`."
}

variable "ip_sku" {
  type        = string
  default     = "Static"
  description = "Tipo de alocação de IP Público que deve ser atribuído ao Application Gateway. Aceita os valores `Static` para alocação fixa e `Dynamic` para alocação dinâmica"
}

variable "is_public_ip_enabled" {
  type        = bool
  default     = true
  description = "Especifica se o Application Gateway terá IP público."
}

variable "is_autoscale_enabled" {
  type        = bool
  default     = false
  description = "Ajusta se deve ou não ser utilizado Autoscaling."
}

variable "autoscale_min_capacity" {
  type        = number
  default     = null
  description = "Define as configurações de Capacity do Autoscaling configurando a capacidade mínima do Application Gateway."
}

variable "autoscale_max_capacity" {
  type        = number
  default     = null
  description = "Define as configurações de Capacity do Autoscaling configurando a capacidade máxima do Application Gateway."
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
  description = "Define a porta de front-end a ser usada pelo Application Gateway. Deve ser `80` ou `443`."
}

variable "frontends" {
  type = list(object({
    name                 = string
    is_public_ip_enabled = bool
    private_ip_address   = string
  }))
  description = "Insere as configurações de frontend do Application Gateway."
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
  description = "Define as configurações de Listener do Application Gateway."
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
  description = "Define as configurações de Health Probe do Application Gateway."
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
  description = "Define as regras de roteamento do Application Gateway."
}

variable "ssl_certificate" {
  type = list(object({
    name                = string
    key_vault_secret_id = string
  }))
  default     = null
  description = "Integra um certificado SSL armazenado no Azure Key Vault ao listener do Application Gateway."
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
  description = "Define configurações de Encaminhamento de URL baseado em path."
}

variable "backend_address_pool" {
  type        = list(string)
  description = "Define quais são os nomes dos backend address pools."
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
  description = "Define as configurações de HTTP dos backends do Application Gateway."
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
  description = "Define o tipo e configurações de redirecionamento do Application Gateway."
}
