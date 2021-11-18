variable "resource_group_name" {
  type        = string
  description = "Nome do resource group a ser utilizado"
}

variable "name" {
  type        = string
  description = "Nome do cluster"
}

variable "location" {
  type        = string
  description = "Localidade a ser utilizada"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags a serem aplicadas ao recurso"
  default     = {}
}
