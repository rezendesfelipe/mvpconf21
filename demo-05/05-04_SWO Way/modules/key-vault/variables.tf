variable "resource_group_name" {
  type = string
}

variable "location" {
  type        = string
  description = "Location do Key-vault"
  default     = null
}

variable "kv_name" {
  type        = string
  description = "Nome do cofre."
}

variable "sku_name" {
  type        = string
  description = "Definição da SKU (standard ou premium)."
}

variable "enabled_for_deployment" {
  type        = bool
  description = "Propriedade que define se máquinas virtuais do Azure têm permissão para recuperar certificados armazenados como segredos no cofre."
  default     = false
}

variable "enabled_for_template_deployment" {
  type        = bool
  description = "Propriedade que define se o Azure Resource Manager tem permissão para recuperar segredos armazenados no cofre."
  default     = false
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "Propriedade que define se  o Azure Disk Encryption tem permissão para recuperar segredos armazenados no cofre."
  default     = false
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "Propriedade que define se a autorização será feita via RBAC ao invés de access policies."
  default     = false
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Propriedade que define se a feature Purge Protection será habilitada."
  default     = false
}

variable "soft_delete_retention_days" {
  type        = number
  description = "Quantidade de dias para retenção do 'soft delete'. (90 >= days >= 7)"
  default     = 90
}

variable "network_acls_bypass" {
  type        = string
  description = "Propriedade que define se os serviços do Azure podem realizar operações no cofre. (AzureServices ou None)"
  default     = "None"
}

variable "network_acls_default_action" {
  type        = string
  description = "Ação a ser realizada quando o tráfego de rede de origem for diferente das regras especificadas. (Allow ou Deny)"
  default     = "Deny"
}

variable "network_acls_ip_rules" {
  type        = list(string)
  description = "Um ou mais endereços de IP ou blocos CIDR que devem ter acesso ao cofre."
  default     = []
}

variable "network_acls_virtual_network_subnet_ids" {
  type        = list(string)
  description = "Um ou mais IDs de subnets que devem ter acesso ao cofre."
  default     = []
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "access_policies" {
  type    = list(any)
  default = []
}
