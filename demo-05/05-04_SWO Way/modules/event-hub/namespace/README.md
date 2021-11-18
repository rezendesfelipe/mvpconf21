# Módulo de Event Hub Namespace
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `name`: Nome do Namespace a ser criado.
* [Obrigatório] `capacity`: Especifica a capacidade/throughput units para um namespace do tier `Standard`.
* [Opcional] `location`: Localização onde o recurso será criado. Por padrão, o módulo utilizará a localização do Resource Group que irá contê-lo.
* [Opcional] `sku`: Define qual tier deverá ser utilizado. Suporta `Basic` e `Standard`. Padrão é `Standard`.
* [Opcional] `auto_inflate_enabled`: Especifica se o auto inflate será habilitado. Padrão é `false`.
* [Opcional] `dedicated_cluster_id`: Especifica o id do cluster onde o namespace deve ser criado.
* [Opcional] `maximum_throughput_units`: Especifica o valor máximo de throughput units quando o auto inflate está habilitado.
* [Opcional] `zone_redundant`: Especifica se o namespace utilizará zonas de disponibilidade.
* [Opcional] `tags`: Tags a serem aplicadas ao recurso.
* [Opcional] `network_rulesets`: Conjunto de regras de rede.
    * `default_action`: A ação padrão quando não há regras correspondentes. Aceita `Allow` e `Deny`. Padrão é `Deny`.
    * `trusted_service_access_enabled`: Define se é permitido que os serviços da Microsoft passem pelo firewall.
    * `virtual_network_rule`
        * `subnet_id`: Id da subnet.
        * `ignore_missing_virtual_network_service_endpoint`: Define se service endpoints devem ser ignorados.
    * `ip_rule`
        * `ip_mask`: Bloco CIDR. 
        * `action`: Ação a ser tomada. Aceita apenas `Allow`.
* [Opcional] `event_hubs`: Lista de Event Hubs que devem ser criados no namespace.
    * `name`: Nome do Event Hub.
    * `partition_count`: Quantidade de partições. Ao utilizar cluster dedicado, o máximo é `1024`, caso contrário, o máximo é `32`.
    * `message_retention`: Quantidade de dias que as mensagens devem ser retidas. Ao utilizar cluster dedicado, o máximo é `90`, caso contrário, o máximo é `7`.

## Ouputs gerados pelo módulo
* `id`: id do Namespace

## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "eventhub" {
  source               = "../../../../modules/event-hub/namespace"
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "eventhubtest"
  capacity             = 20
  event_hubs = [
    {
      name              = "hub01"
      partition_count   = 200
      message_retention = 7
    },
    {
      name              = "hub02"
      partition_count   = 4
      message_retention = 4
    }
  ]
  network_rulesets = [
    {
      default_action = "Deny"
      ip_rule = [
        {
          ip_mask = "0.0.0.0"
          action  = "Allow"
        },
        {
          ip_mask = "255.255.255.255"
          action  = "Allow"
        }
      ]
      trusted_service_access_enabled = true
      virtual_network_rule = [
        {
          ignore_missing_virtual_network_service_endpoint = false
          subnet_id                                       = data.terraform_remote_state.shared.outputs.vnet_subnet_ids[11]
        }
      ]
    }
  ]
}
```
### Exemplo de plan
<details><summary>Expanda para ver o exemplo</summary>

``` Go
Terraform will perform the following actions:

  # module.eventhub.azurerm_eventhub.event_hub["hub01"] will be created
  + resource "azurerm_eventhub" "event_hub" {
      + id                  = (known after apply)
      + message_retention   = 7
      + name                = "hub01"
      + namespace_name      = (known after apply)
      + partition_count     = 200
      + partition_ids       = (known after apply)
      + resource_group_name = "rg-onsite-dev"
      + status              = "Active"
    }

  # module.eventhub.azurerm_eventhub.event_hub["hub02"] will be created
  + resource "azurerm_eventhub" "event_hub" {
      + id                  = (known after apply)
      + message_retention   = 4
      + name                = "hub02"
      + namespace_name      = (known after apply)
      + partition_count     = 4
      + partition_ids       = (known after apply)
      + resource_group_name = "rg-onsite-dev"
      + status              = "Active"
    }

  # module.eventhub.azurerm_eventhub_namespace.ns will be created
  + resource "azurerm_eventhub_namespace" "ns" {
      + auto_inflate_enabled                      = false
      + capacity                                  = 20
      + dedicated_cluster_id                      = (known after apply)
      + default_primary_connection_string         = (sensitive value)
      + default_primary_connection_string_alias   = (sensitive value)
      + default_primary_key                       = (sensitive value)
      + default_secondary_connection_string       = (sensitive value)
      + default_secondary_connection_string_alias = (sensitive value)
      + default_secondary_key                     = (sensitive value)
      + id                                        = (known after apply)
      + location                                  = "eastus2"
      + maximum_throughput_units                  = (known after apply)
      + name                                      = (known after apply)
      + network_rulesets                          = [
          + {
              + default_action                 = "Deny"
              + ip_rule                        = [
                  + {
                      + action  = "Allow"
                      + ip_mask = "0.0.0.0"
                    },
                  + {
                      + action  = "Allow"
                      + ip_mask = "255.255.255.255"
                    },
                ]
              + trusted_service_access_enabled = true
              + virtual_network_rule           = [
                  + {
                      + ignore_missing_virtual_network_service_endpoint = true
                      + subnet_id                                       = "/subscriptions/05853494-3f9a-49ed-922f-d00105861b22/resourceGroups/rg-shared-dev/providers/Microsoft.Network/virtualNetworks/vnet-impulse-dev/subnets/subnet-platform-aks"
                    },
                ]
            },
        ]
      + resource_group_name                       = "rg-onsite-dev"
      + sku                                       = "Standard"
      + zone_redundant                            = true

      + identity {
          + principal_id = (known after apply)
          + tenant_id    = (known after apply)
          + type         = "SystemAssigned"
        }
    }

  # module.eventhub.random_string.random will be created
  + resource "random_string" "random" {
      + id          = (known after apply)
      + length      = 4
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = false
      + result      = (known after apply)
      + special     = false
      + upper       = true
    }
```
</details>

<br/>

Clique [**aqui**](../../../README.md) para voltar para a página principal da documentação.
