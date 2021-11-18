variable "db_name" {
  type        = string
  description = "Nome do recurso."
}

variable "resource_group_name" {
  type        = string
  description = "Nome do resource group."
}

variable "location" {
  type        = string
  description = "Localização do recurso."
  default     = null
}

variable "kind" {
  type        = string
  description = "Especifica o tipo de Cosmos DB. Aceita GlobalDocumentDB e MongoDB."
}

variable "consistency_level" {
  type        = string
  description = "Especifica o nível de consistência. Aceita BoundedStaleness, Eventual, Session, Strong e ConsistentPrefix."
  default     = "Session"
}

variable "max_interval_in_seconds" {
  type        = number
  description = "Obrigatório quando o nível de consistência for BoundedStaleness. Aceita valores entre 5 e 86400 (1 dia)."
  default     = 5
}

variable "max_staleness_prefix" {
  type        = number
  description = "Obrigatório quando o nível de consistência for BoundedStaleness. Aceita valores entre 10 e 2147483647."
  default     = 100
}

variable "geo_locations" {
  type        = list(any)
  description = "Lista de regiões que os dados serão replicados."
  default     = []
}

variable "ip_range_filter" {
  type        = string
  description = "Conjunto de IPs a serem liberados no Firewall do recurso. Aceita uma lista delimitada por vírgula sem espaços."
  default     = ""
}

variable "enable_free_tier" {
  type        = bool
  description = "Especifica se o Free Tier será habilitado."
  default     = false
}

variable "analytical_storage_enabled" {
  type        = bool
  description = "Especifica se o Analytical Storage será habilitado."
  default     = false
}

variable "enable_automatic_failover" {
  type        = bool
  description = "Especifica se o fail over automático será habilitado."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Especifica se conexões provenientes da internet são aceitas."
  default     = true
}

variable "capabilities" {
  type        = list(string)
  description = "Lista de capabilities a serem habilitadas. Aceita AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 e mongoEnableDocLevelTTL."
  default     = []
}

variable "is_virtual_network_filter_enabled" {
  type        = bool
  description = "Especifica se o filtro de virtual networks será habilitado."
  default     = true
}

variable "virtual_network_rules" {
  type        = list(any)
  description = "Lista de ids de subnets que terão acesso ao Cosmos."
  default     = []
}

variable "tags" {
  type    = map(any)
  default = {}
}
