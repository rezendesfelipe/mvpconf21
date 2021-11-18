# Módulo de Postgre-SQL

## Variáveis válidas

Este módulo aceita as seguintes variáveis:
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `location`: Location do PostgreSQL.
* [Obrigatório] `server_name`: Unique server name do PostgreSQL.
* [Obrigatório] `sku_name`: Nome do SKU.
* [Obrigatório] `backup_retention_days`: Retenção dos dias backup.
* [Obrigatório] `geo_redundant_backup_enabled`: GRS backup enabled.
* [Obrigatório] `administrator_login`: Usuário de login.
* [Obrigatório] `administrator_password`: Password do Postgresql, sensite enabled.
* [Obrigatório] `server_version`: Versão do server 9.5 como default.
* [Obrigatório] `ssl_enforcement_enabled`: ssl, by default true.
* [Obrigatório] `public_network_access_enabled`: Public network enabled, default true.
* [Obrigatório] `db_names`: Nome dos bancos de dados.
* [Opcional] `db_charset`: Charset do banco de dados, by default UTF8.
* [Opcional] `db_collation`: Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created, by dafault English_United States.1252.
* [Opcional] `firewall_rule_prefix`: Specifies prefix for firewall rule names.
* [Opcional] `firewall_rules`: The list of maps, describing firewall rules. Valid map items: name, start_ip, end_ip.
* [Opcional] `vnet_rule_name_prefix`: Specifies prefix for vnet rule names.
* [Opcional] `vnet_rules`: The list of maps, describing vnet rules. Valud map items: name, subnet_id.
* [Opcional] `tags`: A map of tags to set on every taggable resources. Empty by default.
* [Opcional] `postgresql_configurations`: A map with PostgreSQL configurations to enable.

## Ouputs gerados pelo módulo

* `server_name`: The name of the PostgreSQL server
* `server_fqdn`: The fully qualified domain name (FQDN) of the PostgreSQL server
* `administrator_login`: administrator_login
* `administrator_password`: administrator_password
* `server_id`: The resource id of the PostgreSQL serverl
* `database_ids`: The list of all database resource ids
* `firewall_rule_ids`: The list of all firewall rule resource ids
* `vnet_rule_ids`: The list of all vnet rule resource ids

## Tips and tricks, we need to add a variable into the variables files from our product
```Go
variable "administrator_password" {
  description = "The Password associated with the administrator_login for the PostgreSQL Server."
  type        = string
  sensitive   = true
}
```
## Casos de uso

### Exemplo como adicionar novas "Firewall_rules"
```Go
firewall_rule_prefix = "firewall-"
  firewall_rules = [
    { name = "test1", start_ip = "10.0.0.5", end_ip = "10.0.0.8" },
    { start_ip = "127.0.0.0", end_ip = "127.0.1.0" },
    { name = "test2", start_ip = "10.0.0.5", end_ip = "10.0.0.8" },
    { start_ip = "127.0.0.0", end_ip = "127.0.1.0" },
  ]
```
## Casos de uso

### Exemplo de código

Terraform 0.14.x

```Go
module "postgresql" {
  source = "../../../../modules/postgre-sql"

  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  server_name                   = "example-server"
  sku_name                      = "GP_Gen5_2"
  storage_mb                    = 5120
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  administrator_login           = "login"
  administrator_password        = var.administrator_password
  server_version                = "9.5"
  ssl_enforcement_enabled       = true
  public_network_access_enabled = true
  db_names                      = ["my_db1", "my_db2"]
  db_charset                    = "UTF8"
  db_collation                  = "English_United States.1252"

  firewall_rule_prefix = "firewall-"
  firewall_rules = [
    { name = "test1", start_ip = "10.0.0.5", end_ip = "10.0.0.8" },
    { start_ip = "127.0.0.0", end_ip = "127.0.1.0" },
  ]

  vnet_rule_name_prefix = "postgresql-vnet-rule-"
  vnet_rules = [
    { name = "subnet1", subnet_id = data.terraform_remote_state.shared.outputs.vnet_subnet_ids[5] }
  ]

  tags = var.tags

  postgresql_configurations = {
    backslash_quote = "on",
  }

  depends_on = [azurerm_resource_group.rg]
}
```
