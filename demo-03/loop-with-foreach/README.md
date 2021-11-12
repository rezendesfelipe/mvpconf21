

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.84.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Datacenter region where resources are going to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Resource Group. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | All details about the subnet that's going to be created. Must use the following inputs: <table><thead><tr><th>Name</th><th>Type</th><th>Default</th><th>Description</th><th>Required</th></tr></thead><tbody><tr><td>name</td><td>`string`</td><td>n/a</td><td>This **must be used as the key of your map**</td><td>yes</td></tr><tr><td>address\_prefix</td><td>`string`</td><td>n/a</td><td>Subnet CIDR address</td><td>yes</td></tr><tr><td>service\_endpoints</td><td>`list(string)`</td><td>`null`</td><td>Service Endpoints to be used with this subnet. Accepted values are: `Microsoft.AzureActiveDirectory`, `Microsoft.CosmosDB`, `Microsoft.ContainerRegistry`, `Microsoft.EventHub`, `Microsoft.KeyVault`, `Microsoft.ServiceBus`, `Microsoft.Sql`, `Microsoft.Storage`, `Microsoft.Web`</td><td>no</td></tr><tr><td>enforce\_private\_link\_endpoint\_network\_policies</td><td>`bool`</td><td>`null`</td><td>Enable or Disable network policies for the private link endpoint on the subnet. Setting this to `true` will **Disable** the policy and setting this to `false` will **Enable** the policy. *Note*: Conflicts with `enforce_private_link_service_network_policies`.</td><td>no</td></tr><tr><td>enforce\_private\_link\_service\_network\_policies</td><td>`bool`</td><td>`null`</td><td>Enable or Disable network policies for the private link service on the subnet. Setting this to `true` will **Disable** the policy and setting this to `false` will **Enable** the policy. *Note*: Conflicts with `enforce_private_link_endpoint_network_policies`.</td><td>no</td></tr><tr><td>delegation</td><td>`map(any)`</td><td>`null`</td><td>must have the following details: <table><thead><tr><th>Name</th><th>Type</th><th>Default</th><th>Description</th><th>Required</th></tr></thead><tbody><tr><td>name</td><td>`string`</td><td>n/a</td><td>Name of your Subnet Delegation</td><td>yes</td></tr><tr><td>service\_actions</td><td>`map(any)`</td><td>n/a</td><td>Must follow the same structure as the [official documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#service_delegation) for this block attribute</td><td>yes</td></tr></tbody></table></td><td>no</td></tr></tbody></table> | `any` | n/a | yes |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | Virtual Network CIDR Address | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Virtual Network Name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of characters to identity the tags. Use the format `{ key = value }`. | `map(any)` | `{}` | no |

# Como fazer o deployment do ambiente

Para a criação do ambiente e simular o comportamento de editar um recurso criado através de `for_each` você irá:
- Criar uma rede virtual através do arquivo `vnet-01.tfvars`
- Modificar a rede virtual criada através do arquivo `vnet-02.tfvars`

Para preparar o ambiente use: 

``` shell
make create-steps
```

Com esta execução um arquivo chamado `vnet01.tfplan` será criado e a partir dele a infraestrutura do terraform será provisionada.

Após a criação do ambiente você deve modificá-lo. Para isso use: 

``` shell
make modify-steps
```

Após realizar estas etapas o ambiente será modificado e você poderá avaliar os impactos que ele irá trazer. Ao final você verá que o arquivo `vnet02.tfplan` foi criado e usado para a modificação do ambiente de rede.

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

