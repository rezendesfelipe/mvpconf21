[Clique para voltar à lista de Módulos](../../README.md)

# Módulo de NSG
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `location`: Local onde será o NSG. Caso não seja inserido, será usado a mesma localização do Resource group
* [Obrigatório] `name`: Nome do NSG.
* [Opcional] `tags`: Tags aplicadas no recurso
* [Opcional] `rules`: Modo de criação das regras. Deve ser criado como um "Map" e deve ser usado neste padrão: 

``` Go
[...]
    rules = [
        {
            name = "nome da regra" // deve ser mencionado
            priority = 100 // número entre 0 a 65535
            direction = "Inbound" // ou "Outbound"
            access = "Allow" // 'Allow' ou 'Deny'. Default é 'Allow'
            protocol = "TCP" // TCP, UDP, ICMP ou '*'. Padrão é '*'
            source_port_range = * // número entre 0 e 65535 ou '*'
            destination_port_range = "3389,443" // número entre 0 e 65535 ou '*' aceita múltiplos valores quando se usa string separadas por vírgula.
            source_address_prefixes = ["10.0.1.0/24","10.2.0.0/23"] // Inserir endereço(s) de Origem. **Aceita Service Tags**
            source_address_prefixes = ["10.0.1.0/24","10.2.0.0/23"] // Inserir endereço(s) de destino. **Aceita Service Tags**
            description = "Descrição da Regra" // Caso não haja qualquer informação será inserido automaticamente "
            source_application_security_group_ids = "subscriptions/****/ASGs/Id" // Id do Application Security Group de Origem
            destination_application_security_group_ids = "subscriptions/****/ASGs/Id" // Id do Application Security Group de Origem
        }
    ]
```


---

## Outputs do módulo
Este módulo produz os seguintes outputs: 
* `nsg_id`: Id do(s) NSG(s) criado(s).
* `nsg_name`: Nome do(s) NSG(s) criado(s). 

## Exemplo de uso
Terraform 0.14.x
``` Go
[...]
module "nsg" {
  source = "../terraform-cloud/modules/nsg"
  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  nsg_name            = "nsg-testing"
  tags                = var.tags
  rules = [
    {
      name                   = "myssh"
      priority               = 201
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "22"
      source_address_prefix  = "10.0.1.0/24"
      description            = "description-myssh"
    },
  ]
}

```
## Exemplo da utilização integrada com outros módulos
<details><summary>Clique para ver o exemplo do console</summary>

``` Go
provider "azurerm" {
  features {}
}
module "nsg" {
  source = "../terraform-cloud/modules/nsg"
  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  nsg_name            = "nsg-testing"
  tags = {
    suite = "impulse/commerce"
    produto = "search/platform/commerce/hub"
    env = "dev/stg/hlg/prd"
    provisioner = "terraform"
    team = "cloud/search/wishlist"
}
  rules = [
    {
      name                   = "myssh"
      priority               = 201
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "22"
      source_address_prefix  = "10.0.1.0/24"
      description            = "description-myssh"
    },
  ]
}
module "rg" {
  source = "../terraform-cloud/modules/rg"
  location = "eastus"
  vertical = "Rafa"
  produto  = "testes"
  ambiente =  "env"
  tags = {
    Owner = "rafael.veloso@softwareone.com"
  }
}
module "vnet" {

  source = "../terraform-cloud/modules/vnet"
  
  vnet_name             = "vnet-test-rafa"
  resource_group_name   = module.rg.rg_name
  address_space         = ["10.0.0.0/16"]
  subnet_names          = ["subnet1","subnet2","subnet3"]
  subnet_prefixes       =  ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  tags = {
    Owner = "rafael.veloso@softwareone.com"
  }
      depends_on            = [module.rg]
}
module "vm-vhd" {
  source              = "../terraform-cloud/modules/vm-vhd"
  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  virtual_network_name = module.vnet.vnet_name
  sn_id                = module.vnet.vnet_subnet_ids[0]
  subnet_names         = module.vnet.vnet_subnet_names[0]
  tags = {
    Owner = "rafael.veloso@softwareone.com"
  }
  vm_name                   = "custom-image"       # nome da VM no formato desejado
  admin_win_pass            = "ComplxP@ssw0rd!"
  admin_win_username        = "azureuser"
  vm_size                   = "standard_b2s"
  depends_on                = [module.rg]
  image_name                = "first"
  gallery_name              = "rafagalleries"
}



```
## Exemplo do Terraform Plan
<details><summary>Clique para ver o exemplo do console</summary>

``` Go
Terraform will perform the following actions:

  # module.nsg.azurerm_network_security_group.nsg will be created
  + resource "azurerm_network_security_group" "nsg" {
      + id                  = (known after apply)
      + location            = "eastus2"
      + name                = "nsg-testing"
      + resource_group_name = "rg-validation"
      + security_rule       = (known after apply)
      + tags                = {
          + "env"   = "dev"
          + "owner" = "Carlos Oliveira"
        }
    }

  # module.nsg.azurerm_network_security_rule.rules[0] will be created
  + resource "azurerm_network_security_rule" "rules" {
      + access                      = "Allow"
      + description                 = "Regra de segurança do tipo Inbound para Allow_RDP"
      + destination_address_prefix  = "*"
      + destination_port_ranges     = [
          + "3389",
          + "443",
        ]
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "Allow_RDP"
      + network_security_group_name = "nsg-testing"
      + priority                    = 100
      + protocol                    = "*"
      + resource_group_name         = "rg-validation"
      + source_address_prefixes     = [
          + "187.38.60.128",
        ]
      + source_port_ranges          = [
          + "0-65535",
        ]
    }

  # module.nsg.azurerm_network_security_rule.rules[1] will be created
  + resource "azurerm_network_security_rule" "rules" {
      + access                      = "Deny"
      + description                 = "Regra de segurança do tipo Outbound para Deny_Internet"
      + destination_address_prefix  = "Internet"
      + destination_port_ranges     = [
          + "0-65535",
        ]
      + direction                   = "Outbound"
      + id                          = (known after apply)
      + name                        = "Deny_Internet"
      + network_security_group_name = "nsg-testing"
      + priority                    = 200
      + protocol                    = "*"
      + resource_group_name         = "rg-validation"
      + source_address_prefix       = "*"
      + source_port_ranges          = [
          + "0-65535",
        ]
    }

Plan: 3 to add, 0 to change, 0 to destroy.

```
</details>