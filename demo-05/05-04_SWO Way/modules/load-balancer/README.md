# Módulo de Azure Load Balancer
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `vnet_name`: Nome da Virtual Network a ser utilizada.
* [Obrigatório] `subnet_name`: Nome da Subnet a ser utilizada.
* [Obrigatório] `name`: Nome do Load Balancer.
* [Obrigatório] `is_public_ip_enabled`: Especifica se o Load Balancer terá frontends com IPs públicos.
* [Obrigatório] `frontends`: Lista de configurações de frontends.
    * `name`: Nome do frontend.
    * `private_ip_address_allocation`: Forma de alocação do IP privado. Aceita `Dynamic` e `Static`. Caso `is_public_ip_enabled` seja `true`, deve passar o valor `null`.
    * `private_ip_address`: Caso `private_ip_address_allocation` seja `Static`, deve passar o endereço de IP privado do frontend. Caso contrário, deve passar `null`.
* [Opcional] `location`: Localização onde o recurso será criado. Por padrão, o módulo utilizará a localização do Resource Group que irá contê-lo.
* [Opcional] `sku`: SKU a ser utilizada. Aceita `Basic` e `Standard`. Default é `Basic`.
* [Opcional] `backends`: Lista de backend pools a serem criados.
    * `name`: Nome do backend pool.
    * `ip_addresses`: Lista de endereços de ip que serão incluídos no backend pool.
* [Opcional] `probes`: Lista de probes.
    * `name`: Nome do probe.
    * `protocol`: Protocolo a ser utilizado pelo probe. Aceita `Http`, `Https` e `Tcp`.
    * `port`: Porta das máquinas de backend que o probe irá utilizar.
    * `request_path`: URI utilizada pelo probe para verificar integridade dos serviços. Ex: `/health`. Obrigatório caso `protocol` seja `Http` ou `Https`.
    * `interval_in_seconds`: O intervalo, em segundos, que o probe respeitará ao realizar requisições de verificação de integridade.
    * `number_of_probes`: Número de tentativas do probe que devem falhar antes de uma máquina ser removida de um backend pool.
* [Opcional] `rules`: Lista de routing rules.
    * `name`: Nome da regra.
    * `frontend_name`: Nome do frontend que essa regra deve ser associada.
    * `backend_pool_name`: Nome do backend pool que essa regra deve ser associada.
    * `probe_name`: Nome do probe que essa regra deve utilizar.
    * `protocol`: Protocolo a ser utilizado pela regra. Aceita `Tcp`, `Udp` e `All`.
    * `frontend_port`: Porta do frontend do Load Balancer a ser utilizada por essa regra.
    * `backend_port`: Porta do backend a ser utilizada.
    * `enable_floating_ip`: Especifica se IPs "flutuantes" serão habilitados para essa regra.
    * `idle_timeout_in_minutes`: Especifica o timeout para conexões TCP. Aceita valores entre `4` e `30` minutos.
    * `load_distribution`: Especifica como o Load Balancer irá distribuir as requisições. Aceita `Default`, `SourceIP` e `SourceIPProtocol`.
    * `disable_outbound_snat`: Especifica se o snat será habilitado.
    * `enable_tcp_reset`: Especifica se TCP Reset será habilitado.
* [Opcional] `tags`: Tags a serem aplicadas ao recurso.

## Ouputs gerados pelo módulo
* `lb_id`: id do Load Balancer
* `lb_be_address_pools_ids`: Lista de ids de backends pools criados

## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
// exemplo de criação de um Load Balancer com IP privado estático
module "ilb" {
  source               = "../../../../modules/load-balancer"
  resource_group_name  = azurerm_resource_group.shared.name
  vnet_name            = "vnet-impulse-dev"
  subnet_name          = "subnet-impulse-dns"
  name                 = "ilb-impulse-dns"
  location             = azurerm_resource_group.shared.location
  sku                  = "Standard"
  is_public_ip_enabled = false
  frontends = [
    {
      name                          = "fe-default"
      private_ip_address_allocation = "Static"
      private_ip_address            = "10.8.0.36"
    }
  ]
  backends = [
    {
      name         = "be-bind"
      ip_addresses = []
    }
  ]
  probes = [
    {
      name                = "probe-default"
      protocol            = "Tcp"
      port                = 80
      request_path        = null
      interval_in_seconds = 20
      number_of_probes    = 4
    }
  ]
  rules = [
    {
      name                    = "ruleTCP"
      frontend_name           = "fe-default"
      backend_pool_name       = "be-bind"
      probe_name              = "probe-default"
      protocol                = "Tcp"
      frontend_port           = 53
      backend_port            = 53
      enable_floating_ip      = false
      idle_timeout_in_minutes = 10
      load_distribution       = "Default"
      disable_outbound_snat   = false
      enable_tcp_reset        = false
    },
    {
      name                    = "ruleUDP"
      frontend_name           = "fe-default"
      backend_pool_name       = "be-bind"
      probe_name              = "probe-default"
      protocol                = "Udp"
      frontend_port           = 53
      backend_port            = 53
      enable_floating_ip      = false
      idle_timeout_in_minutes = 10
      load_distribution       = "Default"
      disable_outbound_snat   = false
      enable_tcp_reset        = false
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

  # module.ilb-bind.azurerm_lb.lb will be created
  + resource "azurerm_lb" "lb" {
      + id                   = (known after apply)
      + location             = "eastus2"
      + name                 = "ilb-impulse-dns"
      + private_ip_address   = (known after apply)
      + private_ip_addresses = (known after apply)
      + resource_group_name  = "rg-shared-dev"
      + sku                  = "Standard"

      + frontend_ip_configuration {
          + id                            = (known after apply)
          + inbound_nat_rules             = (known after apply)
          + load_balancer_rules           = (known after apply)
          + name                          = "fe-default"
          + outbound_rules                = (known after apply)
          + private_ip_address            = "10.8.0.36"
          + private_ip_address_allocation = "static"
          + private_ip_address_version    = "IPv4"
          + public_ip_address_id          = (known after apply)
          + public_ip_prefix_id           = (known after apply)
          + subnet_id                     = "/subscriptions/05853494-3f9a-49ed-922f-d00105861b22/resourceGroups/rg-shared-dev/providers/Microsoft.Network/virtualNetworks/vnet-impulse-dev/subnets/subnet-impulse-dns"
        }
    }

  # module.ilb-bind.azurerm_lb_backend_address_pool.be_pools[0] will be created
  + resource "azurerm_lb_backend_address_pool" "be_pools" {
      + backend_ip_configurations = (known after apply)
      + id                        = (known after apply)
      + load_balancing_rules      = (known after apply)
      + loadbalancer_id           = (known after apply)
      + name                      = "be-bind"
      + outbound_rules            = (known after apply)
      + resource_group_name       = (known after apply)
    }

  # module.ilb-bind.azurerm_lb_probe.probes[0] will be created
  + resource "azurerm_lb_probe" "probes" {
      + id                  = (known after apply)
      + interval_in_seconds = 20
      + load_balancer_rules = (known after apply)
      + loadbalancer_id     = (known after apply)
      + name                = "probe-default"
      + number_of_probes    = 4
      + port                = 80
      + protocol            = "Tcp"
      + resource_group_name = "rg-shared-dev"
    }

  # module.ilb-bind.azurerm_lb_rule.rules[0] will be created
  + resource "azurerm_lb_rule" "rules" {
      + backend_address_pool_id        = (known after apply)
      + backend_port                   = 53
      + disable_outbound_snat          = false
      + enable_floating_ip             = false
      + enable_tcp_reset               = false
      + frontend_ip_configuration_id   = (known after apply)
      + frontend_ip_configuration_name = "fe-default"
      + frontend_port                  = 53
      + id                             = (known after apply)
      + idle_timeout_in_minutes        = 10
      + load_distribution              = "Default"
      + loadbalancer_id                = (known after apply)
      + name                           = "ruleTCP"
      + probe_id                       = (known after apply)
      + protocol                       = "Tcp"
      + resource_group_name            = "rg-shared-dev"
    }

  # module.ilb-bind.azurerm_lb_rule.rules[1] will be created
  + resource "azurerm_lb_rule" "rules" {
      + backend_address_pool_id        = (known after apply)
      + backend_port                   = 53
      + disable_outbound_snat          = false
      + enable_floating_ip             = false
      + enable_tcp_reset               = false
      + frontend_ip_configuration_id   = (known after apply)
      + frontend_ip_configuration_name = "fe-default"
      + frontend_port                  = 53
      + id                             = (known after apply)
      + idle_timeout_in_minutes        = 10
      + load_distribution              = "Default"
      + loadbalancer_id                = (known after apply)
      + name                           = "ruleUDP"
      + probe_id                       = (known after apply)
      + protocol                       = "Udp"
      + resource_group_name            = "rg-shared-dev"
    }
```
</details>

<br/>

Clique [**aqui**](../../README.md) para voltar para a página principal da documentação.
