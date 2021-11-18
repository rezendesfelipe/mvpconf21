# Módulo de Azure NAT Gateway
## Variáveis válidas (Globais)
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado. 
* [Obrigatório] `resource_group_location`: Localidade onde o Nat_Gateway será criado. O valor padrão é `eastus2`.
* [Obrigatório] `ngw_name`: Nome do NAT Gateway que será utilizado para complementar os nomes do PIP, PIP_PREFIX e NAT_GATEWAY
* [Opcional] `tags`: Quais tags serão utilizados. Normalmente ele já irá puxar no momento em que o módulo for chamado.

## Variáveis válidas (Public IP)
* [Opcional] `natgw-pip_count`: Define a quantidade de IPs públicos que serão craidos para o NAT GATEWAY. O padrão é 1. Obs: o Na gateway só suporta o total de 16 Public IPs associados a ele.
* [Obrigatório] `pip_allocation_method`: Método de alocação do IP público. O padrão é `Static`.
* [Obrigatório] `pip_sku`: Sku do IP público. O padrão é `Standard`.

## Variáveis válidas (Nat_Gateway)

* [Obrigatório] `ngw_sku_name`: sku do nat gateway. O valor padrão é O valor padrão é `Standard`.
* [Obrigatório] `ngw_idle_timeout`: valor de timeout de idle. padrão é `4`

## Variáveis válidas (Subnet_Association)
* [Obrigatório] `subnet_id`: lista com a posição das subnets na rede compartilhada.

Um exemplo de como pode ser realizado:
``` Go
 subnet_id = [
    # Commerce PRD - Subnet Names 
    module.shared-vnet.vnet_subnet_ids[0], #"sn-commerce-prd-frontend"
    module.shared-vnet.vnet_subnet_ids[1], #"sn-commerce-prd-backend"
    module.shared-vnet.vnet_subnet_ids[3], #"sn-commerce-prd-mgmt"
  ]
```


## Ouputs gerados pelo módulo
* `ngw_id`: id do nat gateway
* `ngw_resource_guid`: guid do nat gateway

## Casos de uso
``` Go
module "nat-gateway-commerce-dev" {
  source = "../../../../modules/nat-gw"

  resource_group_name     = azurerm_resource_group.shared.name
  resource_group_location = azurerm_resource_group.shared.location

  ngw_name = "ngw-commerce-prd"
  subnet_id = [
    # Commerce PRD - Subnet Names 
    module.shared-vnet.vnet_subnet_ids[0], #"sn-commerce-prd-frontend"
    module.shared-vnet.vnet_subnet_ids[1], #"sn-commerce-prd-backend"
    module.shared-vnet.vnet_subnet_ids[3], #"sn-commerce-prd-mgmt"
  ]
}


```
### Exemplo de código
Terraform 0.14.x
``` Go
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.nat-gateway-commerce-dev.azurerm_nat_gateway.nat-gateway will be created
  + resource "azurerm_nat_gateway" "nat-gateway" {
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + location                = "eastus2"
      + name                    = "ngw-commerce-prd"
      + public_ip_address_ids   = (known after apply)
      + public_ip_prefix_ids    = (known after apply)
      + resource_group_name     = "rg-shared-prd"
      + resource_guid           = (known after apply)
      + sku_name                = "Standard"
    }

  # module.nat-gateway-commerce-dev.azurerm_public_ip.natgw-pip will be created
  + resource "azurerm_public_ip" "natgw-pip" {
      + allocation_method       = "Static"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "eastus2"
      + name                    = "pip-ngw-commerce-prd"
      + resource_group_name     = "rg-shared-prd"
      + sku                     = "Standard"
    }

  # module.nat-gateway-commerce-dev.azurerm_public_ip_prefix.natgw-pip-prefix will be created
  + resource "azurerm_public_ip_prefix" "natgw-pip-prefix" {
      + id                  = (known after apply)
      + ip_prefix           = (known after apply)
      + location            = "eastus2"
      + name                = "pip-prefix-ngw-commerce-prd"
      + prefix_length       = 28
      + resource_group_name = "rg-shared-prd"
      + sku                 = "Standard"
    }

  # module.nat-gateway-commerce-dev.azurerm_subnet_nat_gateway_association.nat-subnet[0] will be created
  + resource "azurerm_subnet_nat_gateway_association" "nat-subnet" {
      + id             = (known after apply)
      + nat_gateway_id = (known after apply)
      + subnet_id      = "/subscriptions/74b0c47d-f13e-4931-b415-f4f0dea7d409/resourceGroups/rg-shared-prd/providers/Microsoft.Network/virtualNetworks/vnet-commerce-prd/subnets/sn-commerce-prd-frontend"
    }

  # module.nat-gateway-commerce-dev.azurerm_subnet_nat_gateway_association.nat-subnet[1] will be created
  + resource "azurerm_subnet_nat_gateway_association" "nat-subnet" {
      + id             = (known after apply)
      + nat_gateway_id = (known after apply)
      + subnet_id      = "/subscriptions/74b0c47d-f13e-4931-b415-f4f0dea7d409/resourceGroups/rg-shared-prd/providers/Microsoft.Network/virtualNetworks/vnet-commerce-prd/subnets/sn-commerce-prd-backend"
    }

  # module.nat-gateway-commerce-dev.azurerm_subnet_nat_gateway_association.nat-subnet[2] will be created
  + resource "azurerm_subnet_nat_gateway_association" "nat-subnet" {
      + id             = (known after apply)
      + nat_gateway_id = (known after apply)
      + subnet_id      = "/subscriptions/74b0c47d-f13e-4931-b415-f4f0dea7d409/resourceGroups/rg-shared-prd/providers/Microsoft.Network/virtualNetworks/vnet-commerce-prd/subnets/sn-commerce-prd-mgmt"
    }

Plan: 6 to add, 0 to change, 0 to destroy.
```



Clique [**aqui**](../../README.md) para voltar para a página principal da documentação.
