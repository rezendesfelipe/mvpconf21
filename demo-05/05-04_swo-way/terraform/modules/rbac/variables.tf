#
#
#


variable "aad_group_display_name" {
  type        = string
  description = "Nome do grupo existente."
}

variable "azurerm_access" {
  type        = map(string)
  description = "Mapa de acessos para a os recursos do Azure."
}
