variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group"
}

variable "location" {
  type        = string
  description = "Localidade do Azure Container Registry"
}

variable "acr_name" {
  type        = string
  default     = "acr"
  description = "Nome do Registro do Container"
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "SKU do Registro de Container. Aceita os valores `Standard`, `Premium` ou `Basic`."
  validation {
    condition     = can(regex("Standard|Premium|Basic", var.sku))
    error_message = "Selecione apenas um dos valores aceitos como SKU: Basic, Standard, ou Premium."
  }
}

variable "enable_admin" {
  type        = bool
  default     = false
  description = "Habilitar ou não o acesso de usuário admin do Registro de Container."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de tags a serem usadas para rotular o Registro de Container."
}