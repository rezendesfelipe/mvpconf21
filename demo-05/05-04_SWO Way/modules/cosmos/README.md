# Módulo de Azure Cosmos DB
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `db_name`: Nome da conta.
* [Obrigatório] `kind`: Especifica o tipo de Cosmos DB. Aceita GlobalDocumentDB e MongoDB.
* [Opcional] `location`: Localização onde o recurso será criado. Por padrão, o módulo utilizará a localização do Resource Group que irá contê-lo.
* [Opcional] `consistency_level`: Especifica o nível de consistência. Aceita BoundedStaleness, Eventual, Session, Strong e ConsistentPrefix.
* [Opcional] `max_interval_in_seconds`: Obrigatório quando o nível de consistência for BoundedStaleness. Aceita valores entre 5 e 86400 (1 dia).
* [Opctional] `max_staleness_prefix`: Obrigatório quando o nível de consistência for BoundedStaleness. Aceita valores entre 10 e 2147483647.
* [Opcional] `geo_locations`: Lista de regiões que os dados serão replicados.
* [Opcional] `ip_range_filter`: Conjunto de IPs a serem liberados no Firewall do recurso. Aceita uma lista delimitada por vírgula sem espaços.
* [Opcional] `enable_free_tier`: Especifica se o Free Tier será habilitado. Default é `false`.
* [Opcional] `analytical_storage_enabled`: Especifica se o Analytical Storage será habilitado. Default é `false`.
* [Opcional] `enable_automatic_failover`: Especifica se o fail over automático será habilitado. Default é `false`.
* [Opcional] `public_network_access_enabled`: Especifica se conexões provenientes da internet são aceitas. Default é `true`.
* [Opcional] `capabilities`: Lista de capabilities a serem habilitadas. Aceita AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 e mongoEnableDocLevelTTL.
* [Opcional] `is_virtual_network_filter_enabled`: Especifica se o filtro de virtual networks será habilitado.
* [Opcional] `virtual_network_rules`: Lista de ids de subnets que terão acesso ao Cosmos.
* [Opcional] `tags`: Tags a serem aplicadas no servidor.

## Ouputs gerados pelo módulo
* `db_id`: id do Cosmos DB
* `db_endpoint`: endpoint utilizado para conectar-se ao Cosmos DB
* `db_primary_key`: chave primária desta conta
* `db_connection_strings`: lista de connection strings disponíveis

## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
// exemplo de criação de um Cosmos DB com a API SQL.
module "db" {
  source              = "../../../modules/cosmos"
  db_name             = "cosmos"
  resource_group_name = "cosmosteste"
  kind                = "GlobalDocumentDB" // para criar com API do MongoDB, substituir por "MongoDB"
  ip_range_filter     = "0.0.0.0,1.1.1.1" // substituir por IPs desejados
  geo_locations       = [
      {
          location = "eastus2"
          failover_priority = 0
          zone_redundant = false
      }
  ]
  capabilities        = ["DisableRateLimitingResponses"]
  // substituir por ids de subnets
  virtual_network_rules = [
    {
      id                                   = "/subscriptions/xxxxxxxxx-xxxxx-xxxxxxx-xxxxxxxx/resourceGroups/cosmosteste/providers/Microsoft.Network/virtualNetworks/teste-vnet/subnets/default"
      ignore_missing_vnet_service_endpoint = true
    },
    {
      id                                   = "/subscriptions/xxxxxxxx-xxxxxx-xxxxxx-xxxxxxxxxxx/resourceGroups/cosmosteste/providers/Microsoft.Network/virtualNetworks/teste-vnet/subnets/default2"
      ignore_missing_vnet_service_endpoint = false
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

  # module.db.azurerm_cosmosdb_account.db will be created
  + resource "azurerm_cosmosdb_account" "db" {
      + analytical_storage_enabled        = false
      + connection_strings                = (sensitive value)
      + enable_automatic_failover         = false
      + enable_free_tier                  = false
      + enable_multiple_write_locations   = false
      + endpoint                          = (known after apply)
      + id                                = (known after apply)
      + ip_range_filter                   = "0.0.0.0,1.1.1.1"
      + is_virtual_network_filter_enabled = true
      + kind                              = "GlobalDocumentDB"
      + location                          = "brazilsouth"
      + name                              = (known after apply)
      + offer_type                        = "Standard"
      + primary_key                       = (sensitive value)
      + primary_master_key                = (sensitive value)
      + primary_readonly_key              = (sensitive value)
      + primary_readonly_master_key       = (sensitive value)
      + public_network_access_enabled     = true
      + read_endpoints                    = (known after apply)
      + resource_group_name               = "cosmosteste"
      + secondary_key                     = (sensitive value)
      + secondary_master_key              = (sensitive value)
      + secondary_readonly_key            = (sensitive value)
      + secondary_readonly_master_key     = (sensitive value)
      + write_endpoints                   = (known after apply)

      + capabilities {
          + name = "DisableRateLimitingResponses"
        }

      + consistency_policy {
          + consistency_level       = "Session"
          + max_interval_in_seconds = (known after apply)
          + max_staleness_prefix    = (known after apply)
        }

      + geo_location {
          + failover_priority = 0
          + id                = (known after apply)
          + location          = "brazilsouth"
          + zone_redundant    = false
        }

      + virtual_network_rule {
          + id                                   = "/subscriptions/xxxxxxxxx-xxxx-xxxx-xxxxxxxxx/resourceGroups/cosmosteste/providers/Microsoft.Network/virtualNetworks/teste-vnet/subnets/default"
          + ignore_missing_vnet_service_endpoint = false
        }
      + virtual_network_rule {
          + id                                   = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxxxxxxxxx/resourceGroups/cosmosteste/providers/Microsoft.Network/virtualNetworks/teste-vnet/subnets/default2"
          + ignore_missing_vnet_service_endpoint = false
        }
    }

  # module.db.random_id.server will be created
  + resource "random_id" "server" {
      + b64_std     = (known after apply)
      + b64_url     = (known after apply)
      + byte_length = 8
      + dec         = (known after apply)
      + hex         = (known after apply)
      + id          = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.
```
</details>

<br/>

Clique [**aqui**](../../README.md) para voltar para a página principal da documentação.
