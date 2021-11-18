[Voltar para o Readme Raiz](../README.md)

# Módulo de Azure Container Registry
## Inputs
Este módulo aceita as seguintes variáveis: 
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `acr_name`: Nome do Registry. Gera uma string aleatória de 4 dígitos após o nome para garantir que será um nome único no ambiente do Azure.
* [Obrigatório] `sku`: SKU do Registry. Aceita os valores `Basic`, `Standard` e `Premium`.
* [Opcional] `Location`: Nome do local onde será implementado. Por padrão usa o mesmo location do Resource Group
* [Opcional] `admin_enabled`: Habilita ou não o acesso administrativo ao repositório. Padrão está definido como `false`.
* [Opcional] `tags`: Quais tags serão utilizados. Normalmente ele já irá puxar no momento em que o módulo for chamado.

## Outputs 
Este módulo produz os seguintes outputs
* `acr_login_server`: Login Server do ACR.
* `acr_admin_username`: UserName do ACR. Só será usado caso `admin_enabled` tenha sido definido como `true`.
* `acr_admin_password`: Password do ACR. Só será usado caso `admin_enabled` tenha sido definido como `true`.

## Exemplo de uso
Terraform 0.14.x
``` Go
module "acr" {
  source              = "../../../../modules/acr"
  resource_group_name = "rg-validacao"
  location            = "eastus2"
  acr_name            = "search1361"
  depends_on          = [azurerm_resource_group.rg]
  tags                = {
      team = "team_name"
      product = "product_name"
  }
}
```

## Exemplo de Plan
<details><summary> Clique para ver um exemplo de como o Terraform criará o plano de execução</summary>

``` Go
Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus2"
      + name     = "rg-validation"
      + tags     = {
          + "env"   = "dev"
          + "owner" = "Carlos Oliveira"
        }
    }

  # module.acr.data.azurerm_resource_group.acr will be read during apply
  # (config refers to values not yet known)
 <= data "azurerm_resource_group" "acr"  {
      + id       = (known after apply)
      + location = (known after apply)
      + name     = "rg-validation"
      + tags     = (known after apply)

      + timeouts {
          + read = (known after apply)
        }
    }

  # module.acr.azurerm_container_registry.acr will be created
  + resource "azurerm_container_registry" "acr" {
      + admin_enabled                 = false
      + admin_password                = (sensitive value)
      + admin_username                = (known after apply)
      + id                            = (known after apply)
      + location                      = "eastus2"
      + login_server                  = (known after apply)
      + name                          = (known after apply)
      + network_rule_set              = (known after apply)
      + public_network_access_enabled = true
      + resource_group_name           = "rg-validation"
      + retention_policy              = (known after apply)
      + sku                           = "Standard"
      + tags                          = {
          + "env"   = "dev"
          + "owner" = "Carlos Oliveira"
        }
      + trust_policy                  = (known after apply)
    }

  # module.acr.random_string.acr will be created
  + resource "random_string" "acr" {
      + id          = (known after apply)
      + length      = 4
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + result      = (known after apply)
      + special     = false
      + upper       = true
    }

Plan: 3 to add, 0 to change, 0 to destroy.
```
</details>