variable "resource_group_name" {
  type        = string
  description = "Nome do resource group a ser utilizado"
}

variable "name" {
  type        = string
  description = "Nome do grupo a ser criado"
}

variable "location" {
  type        = string
  default     = null
  description = "Localidade a ser utilizada. Caso não seja especificado, utilizará localização do resource group"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags a serem aplicadas"
}
