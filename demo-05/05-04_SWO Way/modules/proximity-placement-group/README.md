# Módulo de Proximity Placement Group
## Variáveis válidas
Este módulo aceita as seguintes variáveis:

* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `name`: Nome do recurso.
* [Opcional] `location`: Localidade a ser utilizada. Caso não seja especificado, utilizará localização do Resource Group.
* [Opcional] `tags`: Tags a serem aplicadas ao recurso.

## Ouputs gerados pelo módulo
* `id`: id do recurso

## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "cassandra-proximity-group-zone" {
  source              = "../../../../modules/proximity-placement-group"
  name                = "ppg-platform-cassandra-dev"
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}
```
### Exemplo de plan
<details><summary>Expanda para ver o exemplo</summary>

``` Go
# module.cassandra-proximity-group-zone-2.azurerm_proximity_placement_group.group will be created
  + resource "azurerm_proximity_placement_group" "group" {
      + id                  = (known after apply)
      + location            = "eastus2"
      + name                = "ppg-platform-cassandra-dev3"
      + resource_group_name = "rg-platform-dev"
      + tags                = {
          + "env"         = "dev"
          + "product"     = "platform"
          + "provisioner" = "terraform"
          + "suite"       = "impulse"
          + "team"        = "platform"
        }
    }
```
</details>

<br/>

Clique [**aqui**](../../README.md) para voltar para a página principal da documentação.
