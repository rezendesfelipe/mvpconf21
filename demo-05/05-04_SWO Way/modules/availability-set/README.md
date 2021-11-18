# Módulo de Availability Set
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `as_name`: Especifica o nome do Availability Set. A mudança dessa variável força a criação de um novo recurso.
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado. A mudança dessa variável força a criação de um novo recurso.
* [Opcional] `location`: Especifica a localidade onde o recurso deve ser criado. A mudança dessa variável força a criação de um novo recurso.
* [Opcional] `update_domain_count`: Especifica a quantidade de Update Domains a ser utilizado. A mudança dessa variável força a criação de um novo recurso.
* [Opcional] `fault_domain_count`: Especifica a quantidade de Fault Domains a ser utilizado. A mudança dessa variável força a criação de um novo recurso.
* [Opctional] `tags`: Tags a serem aplicadas no recurso.

## Ouputs gerados pelo módulo
* `as_id`: id do Availability Set

## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "availability-set" {
  source              = "../../../../modules/availability-set"
  resource_group_name = "rg-platform-dev"
  as_name             = "as-cassandra-dev"
}
```
### Exemplo de plan
<details><summary>Expanda para ver o exemplo</summary>

``` Go
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.availability-set.azurerm_availability_set.as will be created
  + resource "azurerm_availability_set" "as" {
      + id                           = (known after apply)
      + location                     = "eastus2"
      + managed                      = true
      + name                         = "as-cassandra-dev"
      + platform_fault_domain_count  = 3
      + platform_update_domain_count = 5
      + resource_group_name          = "rg-platform-dev"
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```
</details>

<br/>

Clique [**aqui**](../../README.md) para voltar para a página principal da documentação.
