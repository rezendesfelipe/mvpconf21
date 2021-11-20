# Azure Container Registry
This module presents an easy way to provision your Azure Container Registry.


## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [random_string.acr](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_resource_group.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Localidade do Azure Container Registry | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nome do Resource Group | `string` | n/a | yes |
| <a name="input_acr_name"></a> [acr\_name](#input\_acr\_name) | Nome do Registro do Container | `string` | `"acr"` | no |
| <a name="input_enable_admin"></a> [enable\_admin](#input\_enable\_admin) | Habilitar ou não o acesso de usuário admin do Registro de Container. | `bool` | `false` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | SKU do Registro de Container. Aceita os valores `Standard`, `Premium` ou `Basic`. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapa de tags a serem usadas para rotular o Registro de Container. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_admin_password"></a> [acr\_admin\_password](#output\_acr\_admin\_password) | Senha do usuário administrador o Azure Container Registry. |
| <a name="output_acr_admin_username"></a> [acr\_admin\_username](#output\_acr\_admin\_username) | Nome do usuário administrador do Container Registry |
| <a name="output_acr_id"></a> [acr\_id](#output\_acr\_id) | Resource ID do Azure Container Registry |
| <a name="output_acr_login_server"></a> [acr\_login\_server](#output\_acr\_login\_server) | Azure Container Registry Login Server Name. |

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

