variable "as_name" {
  type        = string
  description = "Nome do Availability Set"
}

variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group"
}

variable "location" {
  type        = string
  description = "Localização do recurso"
  default     = null
}

variable "update_domain_count" {
  type        = number
  description = "Especifica a quantidade de Update Domains a ser utilizado. A mudança dessa variável força a criação de um novo recurso."
  default     = 5
}

variable "fault_domain_count" {
  type        = number
  description = "Especifica a quantidade de Fault Domains a ser utilizado. A mudança dessa variável força a criação de um novo recurso."
  default     = 3
}

variable "tags" {
  type        = map(any)
  description = "Tags a serem aplicadas ao recurso."
  default     = {}
}
