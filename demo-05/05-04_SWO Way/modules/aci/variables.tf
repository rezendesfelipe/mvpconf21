#General variables
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

#Azure Container Instances -  Group variables
variable "aci_grp_name" {
  type = string
}

variable "aci_os" {
  type        = string
  description = "Valores aceitos é Windows e Linux. Caso a escolha seja Windows somente um container poderá ser provisionado."
}

variable "aci_ip_address_type" {
  type        = string
  default     = "Public"
  description = "Valores aceitos é Public e Private. Default é public"
}

#Azure Container Instances -  Container variables

variable "v_container" {
  type        = map(any)
  description = "Lista contendo os containers e suas configurações"
}
