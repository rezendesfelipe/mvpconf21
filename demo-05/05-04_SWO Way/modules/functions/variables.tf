# Variáveis gerais

variable "resource_group_name" {
  description = "Usará o resource group referente a sua vertical (Required)"
  type        = string
}

variable "location" {
  description = "Definição de localidade para o plano e aplicações Ex: East US (Required)"
  type        = string
  default     = null
}

variable "tags_apps" {
  description = "Definição de tags para otimização de custos"
  type        = map(any)
  default     = {}
}

# Variáveis do app service Plan
variable "vertical" {
  type = string
}
variable "produto" {
  description = "Definição do nome do produto"
  type        = string
}
variable "ambiente" {
  type = string
}
variable "func_kind" {
  description = "Definição da camada de precificação do plano (Free, Shared, Basic, Standard, Premium, PremiumV2, PremiumV3, Isolated)"
  type        = string
  default     = "FunctionApp"
}
variable "func_plan_sku_tier" {
  description = "Definição da camada de precificação do plano (Free, Shared, Basic, Standard, Premium, PremiumV2, PremiumV3, Isolated)"
  type        = string
}
variable "func_plan_sku_size" {
  description = "Definição do tamanho do plano (Small, Medium, Large)"
  type        = string
}

# Variáveis do Function App
variable "func_apps" {
  description = "Definição dos apps deste plano"
  type        = map(any)
}