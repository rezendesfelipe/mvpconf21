

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
| <a name="input_location"></a> [location](#input\_location) | Local onde os recursos serão armazenados | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nome do Resource Group | `string` | n/a | yes |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | Contém uma lista com cada um dos prefixos CIDR que serão usados pela rede virtual | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Nome da rede virtual | `string` | n/a | yes |
| <a name="input_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#input\_subnet\_address\_prefixes) | Lista de prefixos CIDR usados por subnet. <sub><br>**ATENÇÃO**: A ordem aqui importa. se você trocar a posição do CIDR, causará na destruição e reconstrução da(s) subnet(s).</sub> | `list(string)` | `[]` | no |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names) | Nome das subnets que serão criadas. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapa de caracteres com objetivo de criar as tags. Use o formato `{ key = value }`. | `map(any)` | `{}` | no |

# Como fazer o deployment do ambiente

Para a criação do ambiente e simular o comportamento de editar um recurso criado através de `count` você irá:
- Criar uma rede virtual através do arquivo `vnet-01.tfvars`
- Modificar a rede virtual criada através do arquivo `vnet-02.tfvars`

### Para preparar o ambiente 

``` shell
make create-steps
```

Com esta execução um arquivo chamado `vnet01.tfplan` será criado e a partir dele a infraestrutura do terraform será provisionada.

Após a criação do ambiente você deve modificá-lo. Para isso use: 

``` shell
make modify-steps
```

Após realizar estas etapas o ambiente será modificado e você poderá avaliar os impactos que ele irá trazer. Ao final você verá que o arquivo `vnet02.tfplan` foi criado e usado para a modificação do ambiente de rede.

### Para destruir o ambiente
> **ATENÇÃO**: tenha certeza de que está no diretório de demonstração antes de utilizar este comando. Não garantimos a segurança do seu ambiente se estiver usando um ambiente que não seja passível de destruição. Caso tenha dúvidas ou esteja inseguro de usar, remova manualmente os recursos criados no portal do Azure.

Para destruir o ambiente basta usar o comando:
``` shell
make destroy
```

Em poucos segundos o ambiente de laboratório será removido e você terá concluído a demonstração.

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

