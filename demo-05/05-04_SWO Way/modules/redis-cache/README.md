  # Módulo de Azure Redis Cache
## Variáveis válidas
Este módulo aceita as seguintes variáveis:


* [Obrigatório] `resource_group_name` : Nome do Resource Group a ser utilizado.
* [Obrigatório] `capacity` : 
* [Obrigatório] `sku_name` : 
* [Opcional] `enable_non_ssl_port` :
* [Opcional] `minimum_tls_version`:
* [Opcional] `shard_count `:
* [Opcional] `private_static_ip_address`:
* [Opcional] `subnet_id`: Subnet ID de onde haverá integração de do Azure Cache for Redis.
* [Opcional] `enable_authentication`: Valida se quer autenticar ou não no Serviço do Azure Cache for redis. Default é `true`. **IMPORTANTE**: para utilizar esta funcionalidade é obrigatório que a variable `subnet_id` esteja preenchida.
* [Opcional] `is_endpoint_enabled`: Especifica se um private endpoint deve ser criado para esse recurso.
* [Opcional] `firewall_rules`: Lista de regras de firewall a serem aplicadas ao recurso.
* [Opcional] `is_public_network_access_enabled`: Especifica se o cache irá aceitar conexões provenientes da Internet.

## Ouputs gerados pelo módulo
* `storage_account_name`: nome da storage account
* `storage_account_id`: id da storage account
* `storage_account_url`: primary endpoint da storage account
* `storage_access_key`: primary access key da storage account


## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "storage" {
  source                = "../../../module/storage-account"
  resource_group_name   = module.rg.rg_name
  storage_account_name  = "Mystorageacc"
  tier                  = "Standard"
  depends_on            = [module.rg]
}
```
### Exemplo de plan
<details><summary>Expanda para ver o exemplo</summary>

``` Go
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.datacollection.module.storage.azurerm_storage_account.storacc will be created
  + resource "azurerm_storage_account" "storacc" {
      + access_tier                      = (known after apply)
      + account_kind                     = "StorageV2"
      + account_replication_type         = "GRS"
      + account_tier                     = "Standard"
      + allow_blob_public_access         = false
      + enable_https_traffic_only        = true
      + id                               = (known after apply)
      + is_hns_enabled                   = false
      + large_file_share_enabled         = (known after apply)
      + location                         = "eastus2"
      + min_tls_version                  = "TLS1_0"
      + name                             = (known after apply)
      + primary_access_key               = (sensitive value)
      + primary_blob_connection_string   = (sensitive value)
      + primary_blob_endpoint            = (known after apply)
      + primary_blob_host                = (known after apply)
      + primary_connection_string        = (sensitive value)
      + primary_dfs_endpoint             = (known after apply)
      + primary_dfs_host                 = (known after apply)
      + primary_file_endpoint            = (known after apply)
      + primary_file_host                = (known after apply)
      + primary_location                 = (known after apply)
      + primary_queue_endpoint           = (known after apply)
      + primary_queue_host               = (known after apply)
      + primary_table_endpoint           = (known after apply)
      + primary_table_host               = (known after apply)
      + primary_web_endpoint             = (known after apply)
      + primary_web_host                 = (known after apply)
      + resource_group_name              = "rg-impulse-datacollection-dev"
      + secondary_access_key             = (sensitive value)
      + secondary_blob_connection_string = (sensitive value)
      + secondary_blob_endpoint          = (known after apply)
      + secondary_blob_host              = (known after apply)
      + secondary_connection_string      = (sensitive value)
      + secondary_dfs_endpoint           = (known after apply)
      + secondary_dfs_host               = (known after apply)
      + secondary_file_endpoint          = (known after apply)
      + secondary_file_host              = (known after apply)
      + secondary_location               = (known after apply)
      + secondary_queue_endpoint         = (known after apply)
      + secondary_queue_host             = (known after apply)
      + secondary_table_endpoint         = (known after apply)
      + secondary_table_host             = (known after apply)
      + secondary_web_endpoint           = (known after apply)
      + secondary_web_host               = (known after apply)

      + blob_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + delete_retention_policy {
              + days = (known after apply)
            }
        }

      + identity {
          + principal_id = (known after apply)
          + tenant_id    = (known after apply)
          + type         = (known after apply)
        }

      + network_rules {
          + bypass                     = (known after apply)
          + default_action             = (known after apply)
          + ip_rules                   = (known after apply)
          + virtual_network_subnet_ids = (known after apply)
        }

      + queue_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + hour_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }

          + logging {
              + delete                = (known after apply)
              + read                  = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
              + write                 = (known after apply)
            }

          + minute_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }
        }
    }

  # module.datacollection.module.storage.random_id.storacc will be created
  + resource "random_id" "storacc" {
      + b64_std     = (known after apply)
      + b64_url     = (known after apply)
      + byte_length = 8
      + dec         = (known after apply)
      + hex         = (known after apply)
      + id          = (known after apply)
    }
```