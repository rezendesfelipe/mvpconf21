# Módulo de Azure Database for MySQL
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `server_name`: Nome do servidor.
* [Obrigatório] `sku_name`: Especifica a SKU do recurso. Segue o padrão: `tier` + `family` + `cores` (ex: B_Gen4_1, GP_Gen5_8).
* [Obrigatório] `server_version`: Versão do MySQL a ser utilizada. Aceita `5.6`, `5.7` ou `8.0`.
* [Obrigatório] `administrator_login`: Login de administrador do servidor.
* [Obrigatório] `administrator_login_password`: Senha associada ao login de administrador.
* [Obrigatório] `storage_mb`: Armazenamento máximo do servidor. Aceita entre 5120 e 1048576 na camada Básica e entre 5120 e 4194304 nas demais.
* [Opcional] `location`: Localização onde o recurso será criado. Por padrão, o módulo utilizará a localização do Resource Group que irá contê-lo.
* [Opcional] `auto_grow_enabled`: Determina se o servidor utilizará a feature de auto-grow, aumentando a capacidade de armazenamento de acordo com a demanda. Default é `true`.
* [Opcional] `backup_retention_days`: Número de dias de retenção para os backups realizados. Aceita entre 7 e 35. Default é `7`.
* [Opcional] `geo_redundant_backup_enabled`: Determina se os backups serão armazenados de maneira redundante geograficamente. Default é `true`.
* [Opcional] `infrastructure_encryption_enabled`: Determina se a infraestrutura para esse servidor será criptografada ou não. Default é `false`.
* [Opcional] `public_network_access_enabled`: Determina se acessos provenientes da internet são permitidos. Default é `true`.
* [Opcional] `ssl_enforcement_enabled`: Determina se as conexões serão forçadas a utilizar SSL. Default é `true`.
* [Opcional] `ssl_minimal_tls_version_enforced`: Versão mínima do TLS que o servidor suportará. Aceita `TLS1_0`, `TLS1_1`, `TLS1_2` e `TLSEnforcementDisabled`. Default é `TLSEnforcementDisabled`.
* [Opcional] `tags`: Tags a serem aplicadas no servidor.
* [Opcional] `threat_detection_enabled`: Determina se a politica de detecção de ameaças será habilitada. Default é `true`.
* [Opcional] `threat_detection_disabled_alerts`: Lista de alertas que devem ser desabilitados. Aceita Access_Anomaly, Sql_Injection e Sql_Injection_Vulnerability.
* [Opcional] `threat_detection_account_admins`: Determina se as contas de administrador devem ser alertadas via e-mail quando os alertas forem disparados. Default é `true`.
* [Opcional] `threat_detection_email_addresses`: Lista de e-mails que devem ser alertados.
* [Opcional] `threat_detection_retention_days`: Número de dias para manter os logs de auditoria da política de detecção de ameaças.
* [Opcional] `server_configurations`: Lista de configurações do servidor.
* [Opcional] `firewall_rules`: Lista de regras de firewall para acesso ao servidor.
* [Opcional] `vnet_rules`: Lista de regras para acessos provenientes de virtual networks.


## Ouputs gerados pelo módulo
* `server_id`: id do servidor
* `server_fqdn`: FQDN do servidor

## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "mysql" {
  source                       = "../../../modules/mysql"
  resource_group_name          = "mysqlteste"
  server_name                  = "mysql"
  sku_name                     = "GP_Gen5_2"
  server_version               = "5.7"
  administrator_login          = "linx"
  administrator_login_password = "P2ssw0rd@123"
  storage_mb                   = 5120

  //exemplo de como passar configurações do MySQL. Para referência, acessar link: https://dev.mysql.com/doc/refman/5.7/en/server-configuration.html
  server_configurations = [
    {
        name = "max_allowed_packet"
        value = "1073741824"
    },
    {
        name = "slow_query_log"
        value = "OFF"
    }
  ]

  //exemplo de como passar regras de firewall
  firewall_rules = [
    {
      name = "NomeRegra"
      start_ip_address = "10.0.0.0" //substituir pelo ip ou range desejado
      end_ip_address = "10.0.0.0"
    }
  ]

  //exemplo de como passar regras de virtual networks
  vnet_rules = [
    {
      name = "NomeRegra"
      subnet_id = "/subscriptions/.../subnets/subnet_name" //substituir pelo id da subnet
    }
  ]
}
```
### Exemplo de plan
<details><summary>Expanda para ver o exemplo</summary>

``` Go
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.mysql.azurerm_mysql_configuration.server[0] will be created
  + resource "azurerm_mysql_configuration" "server" {
      + id                  = (known after apply)
      + name                = "max_allowed_packet"
      + resource_group_name = "mysqlteste"
      + server_name         = "mysqlbe56710850f9db95"
      + value               = "1073741824"
    }

  # module.mysql.azurerm_mysql_configuration.server[1] will be created
  + resource "azurerm_mysql_configuration" "server" {
      + id                  = (known after apply)
      + name                = "slow_query_log"
      + resource_group_name = "mysqlteste"
      + server_name         = "mysqlbe56710850f9db95"
      + value               = "OFF"
    }

  # module.mysql.azurerm_mysql_firewall_rule.server[0] will be created
  + resource "azurerm_mysql_firewall_rule" "server" {
      + end_ip_address      = "10.0.0.0"
      + id                  = (known after apply)
      + name                = "NomeRegra"
      + resource_group_name = "mysqlteste"
      + server_name         = "mysqlbe56710850f9db95"
      + start_ip_address    = "10.0.0.0"
    }

  # module.mysql.azurerm_mysql_server.server will be created
  + resource "azurerm_mysql_server" "server" {
      + administrator_login               = "linx"
      + administrator_login_password      = (sensitive value)
      + auto_grow_enabled                 = true
      + backup_retention_days             = 7
      + create_mode                       = "Default"
      + fqdn                              = (known after apply)
      + geo_redundant_backup_enabled      = true
      + id                                = (known after apply)
      + infrastructure_encryption_enabled = false
      + location                          = "eastus2"
      + name                              = "mysqlbe56710850f9db95"
      + public_network_access_enabled     = true
      + resource_group_name               = "mysqlteste"
      + sku_name                          = "GP_Gen5_2"
      + ssl_enforcement                   = (known after apply)
      + ssl_enforcement_enabled           = true
      + ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled"
      + storage_mb                        = 5120
      + version                           = "5.7"

      + storage_profile {
          + auto_grow             = (known after apply)
          + backup_retention_days = (known after apply)
          + geo_redundant_backup  = (known after apply)
          + storage_mb            = (known after apply)
        }

      + threat_detection_policy {
          + email_account_admins = true
          + enabled              = true
          + retention_days       = 7
        }
    }

Plan: 4 to add, 0 to change, 0 to destroy.
```
</details>

<br/>

Clique [**aqui**](../../README.md) para voltar para a página principal da documentação.
