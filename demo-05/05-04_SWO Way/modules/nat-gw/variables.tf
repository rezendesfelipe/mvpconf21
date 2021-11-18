variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}

variable "resource_group_location" {
  description = "Name of the resource group to be imported."
  type        = string
  default     = "eastus2"
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
  default     = {}
}
variable "ngw_name" {
  type        = string
  description = "Nome do nat gateway e seus recursos"
}

variable "subnet_id" {
  type        = list(string)
  default     = []
  description = "Lista que conterá as subnets do natgateway"
}

variable "natgw-pip_count" {
  type        = number
  default     = 1
  description = "Contador da quantidade de ips públicos"
}

variable "pip_allocation_method" {
  type        = string
  default     = "Static"
  description = "Método de alocação do IP público"
}

variable "pip_sku" {
  type        = string
  default     = "Standard"
  description = "sku do IP público"
}

variable "ngw_sku_name" {
  type        = string
  default     = "Standard"
  description = "sku do nat gateway"
}

variable "ngw_idle_timeout" {
  type        = number
  default     = 4
  description = "valor de timeout de idle"
}

variable "zones" {
  type        = list(string)
  default     = ["3"]
  description = "Lista de zonas que o recurso deve ser provisionado"
}
