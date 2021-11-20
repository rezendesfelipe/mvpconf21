# Ambiente de Desenvolvimento - MVP Conf LATAM 2021
## Dev Container

Para saber mais sobre essa feature acesse o link [VsCode Dev Container](https://code.visualstudio.com/docs/remote/create-dev-container)

Este repositório possui uma definição de DevContainer permitindo uma mesma experiência para a ferramentas de denvolvimento utilizadas:
- Terraform `[1.0.10]`
- TFLint `[0.33.1]`
- AZ Cli `[latest]`
- Terraform-docs `[0.16.0]`

> Nota: O uso do Dev Container não é mandatório

Extensão:

Caso deseja utilizar é necessário ter a seguinte extensão instalada no Visual Studio Code, além de possuir o [**Docker**](https://docs.docker.com/get-docker/).

[Remote Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)


# Por onde começar
Para a construção do ambiente usamos o Azure DevOps.

Se você deseja criar em seu próprio ambiente de desenvolvimento, preparamos um conjunto de comandos usando `Makefile` para facilitar os comandos.

# Principais comandos

## Como criar todo o ambiente
``` shell
ENV=dev make create-environment
```

> Nota: é obrigatório criar uma variável local antes de criar o ambiente. Você pode usar os valores **dev** ou **prd**.

## Como testar formatação e sintaxe do código
``` shell
make validate-code
```

# Informações necessárias sobre o ambiente do Terraform

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
| <a name="input_acr_enable_admin"></a> [acr\_enable\_admin](#input\_acr\_enable\_admin) | n/a | `string` | n/a | yes |
| <a name="input_acr_name"></a> [acr\_name](#input\_acr\_name) | Nome do Registro de Container. Precisa ser um nome único porque a partir daqui será gerado o nome do registry. | `string` | n/a | yes |
| <a name="input_aks_dns_name"></a> [aks\_dns\_name](#input\_aks\_dns\_name) | Definição do nome que será utilizado para o AKS e também dns do cluster | `string` | n/a | yes |
| <a name="input_aks_enable_attach_acr"></a> [aks\_enable\_attach\_acr](#input\_aks\_enable\_attach\_acr) | Força o attach ou não do Kubernetes Services com o Azure Container Services (Obrigatório verificar a documentação adequada) | `bool` | n/a | yes |
| <a name="input_aks_enable_autoscaling"></a> [aks\_enable\_autoscaling](#input\_aks\_enable\_autoscaling) | Habilita ou não as opções de autoscaling do default node pool. | `bool` | n/a | yes |
| <a name="input_aks_enable_log_analytics_workspace"></a> [aks\_enable\_log\_analytics\_workspace](#input\_aks\_enable\_log\_analytics\_workspace) | Habilita ou não o uso do Log Analytics. Neste momento não é possível associar a um Log Analytics Workspace existente. | `bool` | n/a | yes |
| <a name="input_aks_is_identity_enabled"></a> [aks\_is\_identity\_enabled](#input\_aks\_is\_identity\_enabled) | Habilitar ou não o uso de identidade gerenciada. | `bool` | n/a | yes |
| <a name="input_aks_k8s_version"></a> [aks\_k8s\_version](#input\_aks\_k8s\_version) | Versão do Kubernetes para o Kubernetes Services. | `string` | n/a | yes |
| <a name="input_aks_node_subnet"></a> [aks\_node\_subnet](#input\_aks\_node\_subnet) | Subnet do default node. | `string` | n/a | yes |
| <a name="input_aks_node_vm_size"></a> [aks\_node\_vm\_size](#input\_aks\_node\_vm\_size) | Size da VM do default node | `string` | n/a | yes |
| <a name="input_aks_rbac_aad_admin_group_object_ids"></a> [aks\_rbac\_aad\_admin\_group\_object\_ids](#input\_aks\_rbac\_aad\_admin\_group\_object\_ids) | Object ID of groups with admin access. | `list(string)` | n/a | yes |
| <a name="input_aks_rbac_aad_managed"></a> [aks\_rbac\_aad\_managed](#input\_aks\_rbac\_aad\_managed) | Habilitar ou não gestão de RBAC de Azure AD Gerenciado. | `bool` | n/a | yes |
| <a name="input_default_aks_dns_ip"></a> [default\_aks\_dns\_ip](#input\_default\_aks\_dns\_ip) | IP do DNS (deve estar dentro do range de IP do `aks_network_cidr`). | `string` | n/a | yes |
| <a name="input_default_aks_docker_bridge"></a> [default\_aks\_docker\_bridge](#input\_default\_aks\_docker\_bridge) | endereço CIDR para ser usado como Docker Bridge. | `string` | n/a | yes |
| <a name="input_default_aks_network_cidr"></a> [default\_aks\_network\_cidr](#input\_default\_aks\_network\_cidr) | Endereço CIDR da rede do Kubernetes Service. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | O nome do seu Resource Group | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Mapa de caracteres que deve conter as informações da sua subnet. Para referências e como usar consulte o [Módulo VNET](../../modules/vnet/README.md). | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapa de caracteres identificando através de `chave = valor` quais são os rótulos dos recursos. | `any` | n/a | yes |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | Lista de todos os address spaces que serão usados pelo AKS. | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Nome da Rede virtual a ser consumida pelo AKS. | `string` | n/a | yes |
| <a name="input_aks_additional_node_pools"></a> [aks\_additional\_node\_pools](#input\_aks\_additional\_node\_pools) | O mapa de objetos para configurar um ou mais node pools adicinais com um número de VMs, seus sizes e Disponibilidade de zona. | <pre>map(object({<br>    additional_node_name           = string<br>    node_count                     = number<br>    vm_size                        = string<br>    zones                          = list(string)<br>    max_pods                       = number<br>    os_disk_size                   = number<br>    node_os                        = string<br>    cluster_auto_scaling           = bool<br>    cluster_auto_scaling_min_count = number<br>    cluster_auto_scaling_max_count = number<br>    enable_public_ip               = bool<br>  }))</pre> | `{}` | no |
| <a name="input_aks_default_node_settings"></a> [aks\_default\_node\_settings](#input\_aks\_default\_node\_settings) | Configurações de `max_nodes` e `min_nodes` quando a opção `enable_autoscaling` está definida como `true`. | `map(any)` | `{}` | no |
| <a name="input_aks_enable_azure_active_directory"></a> [aks\_enable\_azure\_active\_directory](#input\_aks\_enable\_azure\_active\_directory) | Habilitar ou não Integração com Azure Active Directory. | `bool` | `false` | no |
| <a name="input_aks_log_analytics_workspace_name"></a> [aks\_log\_analytics\_workspace\_name](#input\_aks\_log\_analytics\_workspace\_name) | nome do workspace do Log Analytics. É obrigatório caso `enable_log_analytics_workspace` for marcado como `true` | `string` | `null` | no |
| <a name="input_aks_max_pods"></a> [aks\_max\_pods](#input\_aks\_max\_pods) | Quantidade máxima de Pods por node (dentro do Default node). | `number` | `30` | no |
| <a name="input_aks_network_plugin"></a> [aks\_network\_plugin](#input\_aks\_network\_plugin) | Nome do Network plugin usado pelo Kubernetes Services. Use `azure` para a rede avançada (Azure CNI) ou `kubenet` para a rede básica. | `string` | `"azure"` | no |
| <a name="input_aks_network_policy"></a> [aks\_network\_policy](#input\_aks\_network\_policy) | Nome da Network Policy usada pelo Kubernete Services. Utilize `azure`, `calico` ou `none`. | `string` | `"azure"` | no |
| <a name="input_aks_node_av_zone"></a> [aks\_node\_av\_zone](#input\_aks\_node\_av\_zone) | n/a | `list(number)` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| <a name="input_aks_node_name"></a> [aks\_node\_name](#input\_aks\_node\_name) | Nome do Default node do Kubernetes Services. | `string` | `"default"` | no |
| <a name="input_aks_node_vm_count"></a> [aks\_node\_vm\_count](#input\_aks\_node\_vm\_count) | Número de Nodes (VMs) que serão criados para o default node do Kubernetes Services. | `number` | `2` | no |
| <a name="input_aks_node_vm_disk_size"></a> [aks\_node\_vm\_disk\_size](#input\_aks\_node\_vm\_disk\_size) | Tamanho em GB do disco de SO do Node | `number` | `30` | no |
| <a name="input_location"></a> [location](#input\_location) | A região do datacenter onde seus recursos serão criados. | `string` | `"brazilsouth"` | no |
| <a name="input_vnet_peering_settings"></a> [vnet\_peering\_settings](#input\_vnet\_peering\_settings) | Mapa de caracteres apresentando as configurações de peering. `Key` é o nome da conexão e `value` deve conter `remove_vnet_id` e o valor deve ser o Resource Id da VNET de destino. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_login_server"></a> [acr\_login\_server](#output\_acr\_login\_server) | Identificador do Azure Container Registry. |
| <a name="output_addon_profile"></a> [addon\_profile](#output\_addon\_profile) | Informações sobre o Addon Profile do AKS |
| <a name="output_aks_cluster_name"></a> [aks\_cluster\_name](#output\_aks\_cluster\_name) | Nome do Cluster de Kubernetes. |
| <a name="output_aks_dns_name"></a> [aks\_dns\_name](#output\_aks\_dns\_name) | DNS Name designado para o cluster Kubernetes |
| <a name="output_identity"></a> [identity](#output\_identity) | Managed Identity do AKS. |
| <a name="output_kube_admin_config"></a> [kube\_admin\_config](#output\_kube\_admin\_config) | Configurações de Administrador do Kubernetes. |
| <a name="output_kube_config_raw"></a> [kube\_config\_raw](#output\_kube\_config\_raw) | 100% de todas as informações do cluster |

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

