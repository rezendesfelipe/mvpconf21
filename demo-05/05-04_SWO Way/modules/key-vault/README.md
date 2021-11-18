# Módulo de Key Vault
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `kv_name`: Nome da Key Vault.
* [Obrigatório] `sku_name`: Camada do recurso. Aceita `standard` ou `premium`.
* [Opcional] `enabled_for_deployment`: Propriedade que define se máquinas virtuais do Azure têm permissão para recuperar certificados armazenados como segredos no cofre. Default é `false`.
* [Opcional] `enabled_for_template_deployment`: Propriedade que define se o Azure Resource Manager tem permissão para recuperar segredos armazenados no cofre. Default é `false`.
* [Opcional] `enabled_for_disk_encryption`: Propriedade que define se  o Azure Disk Encryption tem permissão para recuperar segredos armazenados no cofre. Default é `false`.
* [Opcional] `enable_rbac_authorization`: Propriedade que define se a autorização será feita via RBAC ao invés de access policies. Default é `false`.
* [Opcional] `purge_protection_enabled`: Propriedade que define se a feature 'purge protection' será habilitada. Default é `false`.
* [Opcional] `soft_delete_retention_days`: Quantidade de dias para retenção do 'soft delete'. Pode variar entre 7 e 90 (default) dias.
* [Opcional] `network_acls_bypass`: Propriedade que define se os serviços do Azure podem realizar operações no cofre. Aceita AzureServices ou None (default).
* [Opcional] `network_acls_default_action`: Ação a ser realizada quando o tráfego de rede de origem for diferente das regras especificadas. Aceita Allow ou Deny (default).
* [Opcional] `network_acls_ip_rules`: Um ou mais endereços de IP ou blocos CIDR que devem ter acesso ao cofre.
* [Opcional] `network_acls_virtual_network_subnet_ids`: Um ou mais IDs de subnets que devem ter acesso ao cofre.
* [Opcional] `tags`: Tags a serem aplicadas ao cofre.
* [Opcional] `access_policies`: Lista de access policies a serem adicionados ao cofre.


## Ouputs gerados pelo módulo
* `key_vault_id`: id do key vault
* `key_vault_name`: nome do key vault
* `key_vault_uri`: uri do key vault

## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "kv" {
  source                 = "../../../modules/key-vault"
  resource_group_name    = module.rg.rg_name
  kv_name                = "kv"
  sku_name               = "standard"

  // exemplo de como passar access policies
  access_policies        =  [
    {
        object_id = "xxxxxx-xxxxx-xxxx-xxxx-xxxxxxxxx"
        key_permissions = [
            "get",
            "list"
        ]
        secret_permissions = [
            "get",
            "list"
        ]
        certificate_permissions = [
            "get"
        ]
        storage_permissions = []
    }
  ]
  depends_on             = [module.rg]
}
```
### Exemplo de plan
<details><summary>Expanda para ver o exemplo</summary>

``` Go
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_key_vault.kv will be created
  + resource "azurerm_key_vault" "kv" {
      + access_policy                   = (known after apply)
      + enable_rbac_authorization       = false
      + enabled_for_deployment          = true
      + enabled_for_disk_encryption     = true
      + enabled_for_template_deployment = true
      + id                              = (known after apply)
      + location                        = "eastus"
      + name                            = (known after apply)
      + purge_protection_enabled        = true
      + resource_group_name             = "kvteste"
      + sku_name                        = "standard"
      + soft_delete_enabled             = (known after apply)
      + soft_delete_retention_days      = 7
      + tags                            = {
          + "key" = "value"
        }
      + tenant_id                       = "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
      + vault_uri                       = (known after apply)

      + network_acls {
          + bypass         = "AzureServices"
          + default_action = "Deny"
        }
    }

  # random_id.kv will be created
  + resource "random_id" "kv" {
      + b64_std     = (known after apply)
      + b64_url     = (known after apply)
      + byte_length = 8
      + dec         = (known after apply)
      + hex         = (known after apply)
      + id          = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + key_vault_id   = (known after apply)
  + key_vault_name = (known after apply)
  + key_vault_uri  = (known after apply)
```
</details>

<br/>

Clique [**aqui**](../../README.md) para voltar para a página principal da documentação.
