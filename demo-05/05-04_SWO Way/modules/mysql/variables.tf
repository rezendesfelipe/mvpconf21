# Server configuration

variable "server_name" {
  type        = string
  description = "Nome do servidor."
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type        = string
  description = "Localização do recurso."
  default     = null
}

variable "sku_name" {
  type        = string
  description = "Especifica a SKU do recurso. Segue o padrão: tier + family + cores (ex: B_Gen4_1, GP_Gen5_8)."
}

variable "server_version" {
  type        = string
  description = "Versão do MySQL a ser utilizada. Aceita 5.6, 5.7 ou 8.0."
}

variable "administrator_login" {
  type        = string
  description = "Login de administrador do servidor."
}

variable "administrator_login_password" {
  sensitive   = true
  type        = string
  description = "Senha associada ao login de administrador."
}

variable "auto_grow_enabled" {
  type        = bool
  description = "Determina se o servidor utilizará a feature de auto-grow, aumentando a capacidade de armazenamento de acordo com a demanda."
  default     = true
}

variable "backup_retention_days" {
  type        = number
  description = "Número de dias de retenção para os backups realizados. Aceita entre 7 e 35."
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  type        = bool
  description = "Determina se os backups serão armazenados de maneira redundante geograficamente."
  default     = true
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  description = "Determina se a infraestrutura para esse servidor será criptografada ou não."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Determina se acessos públicos são permitidos."
  default     = true
}

variable "ssl_enforcement_enabled" {
  type        = bool
  description = "Determina se as conexões serão forçadas a utilizar SSL."
  default     = true
}

variable "ssl_minimal_tls_version_enforced" {
  type        = string
  description = "Versão mínima do TLS que o servidor suportará. Aceita TLS1_0, TLS1_1, TLS1_2 e TLSEnforcementDisabled."
  default     = "TLSEnforcementDisabled"
}

variable "storage_mb" {
  type        = number
  description = "Armazenamento máximo do servidor. Aceita entre 5120 e 1048576 na camada Básica e entre 5120 e 4194304 nas demais."
}

variable "tags" {
  type        = map(any)
  description = "Tags a serem aplicadas no servidor."
  default     = {}
}

variable "threat_detection_enabled" {
  type        = bool
  description = "Determina se a politica de detecção de ameaças será habilitada."
  default     = true
}

variable "threat_detection_disabled_alerts" {
  type        = list(string)
  description = "Lista de alertas que devem ser desabilitados. Aceita Access_Anomaly, Sql_Injection e Sql_Injection_Vulnerability."
  default     = []
}

variable "threat_detection_account_admins" {
  type        = bool
  description = "Determina se as contas de administrador devem ser alertadas via e-mail quando os alertas forem disparados."
  default     = true
}

variable "threat_detection_email_addresses" {
  type        = list(string)
  description = "Lista de e-mails que devem ser alertados."
  default     = []
}

variable "threat_detection_retention_days" {
  type        = number
  description = "Número de dias para manter os logs de auditoria da política de detecção de ameaças."
  default     = 7
}

variable "server_configurations" {
  type        = list(any)
  description = "Lista de configurações do servidor."
  default     = []
}

variable "firewall_rules" {
  type        = list(any)
  description = "Lista de regras de firewall para acesso ao servidor."
  default     = []
}

variable "vnet_rules" {
  type        = list(any)
  description = "Lista de regras para acessos provenientes de virtual networks."
  default     = []
}
