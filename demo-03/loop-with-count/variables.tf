variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group"
  default     = "rg-vnet-with-count"
}

variable "location" {
  type        = string
  description = "Local onde os recursos serão armazenados"
  default     = "eastus2"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres com objetivo de criar as tags. Use o formato `{ key = value }`."
}

variable "vnet_name" {
  type        = string
  description = "Nome da rede virtual"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Contém uma lista com cada um dos prefixos CIDR que serão usados pela rede virtual"
}

variable "subnet_names" {
  type        = list(string)
  default     = []
  description = "Nome das subnets que serão criadas."
}

variable "subnet_address_prefixes" {
  type        = list(string)
  default     = []
  description = "Lista de prefixos CIDR usados por subnet. <sub>\n**ATENÇÃO**: A ordem aqui importa. se você trocar a posição do CIDR, causará na destruição e reconstrução da(s) subnet(s).</sub>"
}
