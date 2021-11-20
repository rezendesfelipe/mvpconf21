# Role Based Access Control

Neste momento este módulo suporta fazer atribuição de RBAC nas seguintes condições:
- Somente grupos do AD são elegíveis para serem adicionados
- Os grupos do AD devem previamente existir



## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.rbac](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_group.existing](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_group_display_name"></a> [aad\_group\_display\_name](#input\_aad\_group\_display\_name) | Nome do grupo existente. | `string` | n/a | yes |
| <a name="input_azurerm_access"></a> [azurerm\_access](#input\_azurerm\_access) | Mapa de acessos para a os recursos do Azure. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rbac_definition_name"></a> [rbac\_definition\_name](#output\_rbac\_definition\_name) | Nome da Definition do RBAC |
| <a name="output_rbac_scope"></a> [rbac\_scope](#output\_rbac\_scope) | Escopo de permissionamento do RBAC |

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

