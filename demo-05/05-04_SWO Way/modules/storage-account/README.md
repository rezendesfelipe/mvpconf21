# Módulo de Storage Account
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `storage_account_name`: Nome da Rede virtual.
* [Obrigatório] `tier`: Que tipo de performance espera-se. Padrão é `Standard` e tambem aceita `Premium`.
* [Opcional] `kind`: Qual SKU do do blob storage é usado. Padrão é `StorageV2`.
* [Opcional] `replication`: Que tipo de replicação será usada pela Storage Account. Default é `GRS`.
* [Opcional] `tags`: Quais tags serão utilizados. Normalmente ele já irá puxar no momento em que o módulo for chamado.
* [Opcional] `static_website_enabled`: Especifica se o armazenamento para websites estáticos será habilitado.
* [Opcional] `static_website`: Obrigatório caso `static_website_enabled` seja `true`. Bloco que define caminho para os arquivos do website (ver exemplo de código).
* [Opcional] `storacc_containers`: Utiliza-lo quando houver a necessidade de criar containers dentro da storage account. No bloco chamado, só é necessário colocar o nome do container em "name" e qual o tipo de acesso em "container_access_type". Valores válidos para o tipo são: blob, container ou private.

### Exemplo de código
Terraform 0.14.x
``` Go

 storacc_containers   = {
     cont_airflow = { 
      name = "airflow-logs"
      container_access_type = "private"     
   }
   cont_mail_ignition = { 
      name = "mail-ignition"
      container_access_type = "private"     
   }

}
```

## Ouputs gerados pelo módulo
* `storage_account_name`: nome da storage account
* `storage_account_id`: id da storage account
* `storage_account_url`: primary endpoint da storage account
* `storage_access_key`: primary access key da storage account
* `storage_account_primary_web_host`: primary endpoint para acesso ao website estático (caso existir)


## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "storage" {
  source                = "../../../module/storage-account"
  resource_group_name   = module.rg.rg_name
  storage_account_name  = "Mystorageacc"
  tier                  = "Standard"
  // Exemplo de como criar uma storage account com suporte para website estático
  static_website_enabled = true
  static_website = {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
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