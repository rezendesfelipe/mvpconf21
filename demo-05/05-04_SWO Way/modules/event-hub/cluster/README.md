# Módulo de Event Hub Cluster
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `name`: Nome do Cluster Event Hub.
* [Opcional] `location`: Localização onde o recurso será criado. Por padrão, o módulo utilizará a localização do Resource Group que irá contê-lo.
* [Opcional] `tags`: Tags a serem aplicadas ao recurso.

## Ouputs gerados pelo módulo
* `id`: id do Cluster

## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "eventhub_cluster" {
  source              = "../../../../modules/event-hub/cluster"
  resource_group_name = azurerm_resource_group.rg.name
  name                = "eventhubcluster"
}
```
### Exemplo de plan
<details><summary>Expanda para ver o exemplo</summary>

``` Go
Terraform will perform the following actions:

    # module.eventhub_cluster.azurerm_eventhub_cluster.cluster will be created
  + resource "azurerm_eventhub_cluster" "cluster" {
      + id                  = (known after apply)
      + location            = "eastus2"
      + name                = "eventhubclustertest"
      + resource_group_name = "rg-onsite-dev"
      + sku_name            = "Dedicated_1"
    }
```
</details>

<br/>

Clique [**aqui**](../../../README.md) para voltar para a página principal da documentação.
