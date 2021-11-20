# Módulo Network Security Group

Este módulo apresenta as entradas aceitas bem como as saídas que ele produz.



## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_resource_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nome do Resource group | `string` | n/a | yes |
| <a name="input_destination_address_prefix"></a> [destination\_address\_prefix](#input\_destination\_address\_prefix) | Destination address prefix to be applied to all predefined rules list(string) only allowed one element (CIDR, `*`, source IP range or Tags) Example ["10.0.3.0/24"] or ["VirtualNetwork"] | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_destination_address_prefixes"></a> [destination\_address\_prefixes](#input\_destination\_address\_prefixes) | Destination address prefix to be applied to all predefined rules Example ["10.0.3.0/32","10.0.3.128/32"] | `list(string)` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Localização da região do Azure. | `string` | `"eastus2"` | no |
| <a name="input_nsg_name"></a> [nsg\_name](#input\_nsg\_name) | Nome do Network Security Group | `string` | `"nsg"` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | Regras de segurança para o NSG usando este formato = [`priority`, `direction`, `access`, `protocol`, `source_port_range`, `destination_port_range`, `source_address_prefix`/`source_address_prefix`, `destination_address_prefix`/`destination_address_prefixes`, `description`] | `any` | `[]` | no |
| <a name="input_source_address_prefix"></a> [source\_address\_prefix](#input\_source\_address\_prefix) | source address prefix to be applied to all predefined rules list(string) only allowed one element (CIDR, `*`, source IP range or Tags) Example ["10.0.3.0/24"] or ["VirtualNetwork"] | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_source_address_prefixes"></a> [source\_address\_prefixes](#input\_source\_address\_prefixes) | Destination address prefix to be applied to all predefined rules Example ["10.0.3.0/32","10.0.3.128/32"] | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapa de tags usadas para o recurso. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nsg_id"></a> [nsg\_id](#output\_nsg\_id) | Resource ID do Network Security Group. |
| <a name="output_nsg_name"></a> [nsg\_name](#output\_nsg\_name) | Nome do Network Security Group. |

> Nota sobre como criar regras de NSG:
``` Go
[...]
  rules = [
      {
          name = "nome da regra" 
          // Campo obrigatório
          priority = 100 
          // número EXCLUSIVO entre 0 a 65535
          // Campo obrigatório
          direction = "Inbound" 
          // Aceita 'Inbound' ou 'Outbound'. Default é 'Inbound'
          access = "Allow" 
          // 'Allow' ou 'Deny'. Default é 'Allow'
          protocol = "TCP" 
          // TCP, UDP, ICMP ou '*'. Padrão é '*'
          source_port_range = "*" 
          // número entre 0 e 65535 ou '*'. Padrão é '*'
          destination_port_range = "3389,443,5000-5015" 
          // número entre 0 e 65535 ou '*' aceita múltiplos valores quando se usa string separadas por vírgula.
          // Padrão é '0-65535'
          source_address_prefixes = ["10.0.1.0/24","10.2.0.0/23"] 
          // Inserir endereço(s) de Origem. 
          // NÃO Aceita Service Tags. 
          // NÃO USE COM source_address_prefix
          destination_address_prefixes = ["10.0.1.0/24","10.2.0.0/23"] 
          // Inserir endereço(s) de destino.
          // NÃO Aceita Service Tags
          // NÃO USE COM destination_address_prefix
          source_address_prefix = "10.0.1.0/24" 
          // Inserir endereço(s) de Origem. 
          // Aceita Service Tags. 
          // NÃO USE COM source_address_prefixes
          destination_address_prefix = "10.2.0.0/23"
          // Inserir endereço(s) de destino. 
          // Aceita Service Tags
          // NÃO USE COM destination_address_prefixes
          description = "Descrição da Regra" 
          // Caso não haja qualquer informação será inserido automaticamente"
          source_application_security_group_ids = "subscriptions/****/ASGs/Id" 
          // Id do Application Security Group de Origem
          // NÃO PODE ser usado junto com source_address_prefix ou source_address_prefixes
          destination_application_security_group_ids = "subscriptions/****/ASGs/Id" 
          // Id do Application Security Group de Origem
          // NÃO PODE ser usado junto com destination_address_prefix ou destination_address_prefixes
      }
  ]
```

## Exemplo no terraform 1.x
### NSG Simples

``` Go
module "nsg" {
  source              = "../terraform-cloud/modules/nsg"
  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  nsg_name            = "nsg-testing"
  tags                = var.tags
  rules = [
    {
      name                   = "allow_ssh_in"
      priority               = 201
      direction              = "Inbound"
      destination_port_range = "22"
      source_address_prefix  = "10.0.1.0/24"
      description            = "description-myssh"
    },
  ]
}

```

### NSG com outros módulos

``` Go
provider "azurerm" {
  features {}
}

module "nsg" {
  source              = "../terraform-cloud/modules/nsg"
  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  nsg_name            = "nsg-testing"
  tags = {
    suite       = "mvpconf21"
    produto     = "app1"
    env         = "dev"
    provisioner = "terraform"
    team        = "cloud"
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
    }
  ]
}

module "rg" {
  source   = "../terraform-cloud/modules/rg"
  location = "eastus"
  vertical = "Rafa"
  produto  = "testes"
  ambiente = "env"
  tags = {
    Owner = "rafael.veloso@softwareone.com"
  }
}

module "vnet" {
  source              = "../terraform-cloud/modules/vnet"
  vnet_name           = "vnet-test-rafa"
  resource_group_name = module.rg.rg_name
  address_space       = ["10.0.0.0/16"]
  subnets = {
    subnet1 = {
      address_prefix = "10.0.0.0/24"
    }
    subnet2 = {
      address_prefix = "10.0.1.0/24"
    }
  }
  nsg_ids = {
    subnet1 = module.nsg.nsg_id
  }

  tags = {
    Owner = "rafael.veloso@softwareone.com"
  }
  depends_on = [module.rg]
}

```

### NSG com Service Tags

``` Go
module "nsg" {
  source              = "../terraform-cloud/modules/nsg"
  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  nsg_name            = "nsg-testing"
  tags                = var.tags
  rules = [
    {
      name                       = "deny_internet_out"
      priority                   = 201
      direction                  = "Outbound"
      destination_port_range     = "80,443"
      destination_address_prefix = "Internet"
    },
    {
      name                       = "allow_AzureCloud_in"
      priority                   = 100
      direction                  = "Inbound"
      destination_address_prefix = "AzureCloud"
    },
  ]
}

```

## Deseja contribuir?

Para contruibuir com este repositório você deve instalar o [**Terraform-docs**](https://terraform-docs.io/user-guide/installation/).
Etapas: 
  * Clone este repositório;
  * Crie uma branch;
  * Realize todas as modificações que deseja;
  * Faça o commit e crie uma tag (v1.1.0, v1.2.3, etc);
  * Documente o código usando `make all`;
  * Faça o push da sua branch seguido de um Pull Request.

<sub>Para dúvidas mande um contato: [carlos.oliveira@softwareone.com](mailto:carlos.oliveira@softwareone.com)</sub>

