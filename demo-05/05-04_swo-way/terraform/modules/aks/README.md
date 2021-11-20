# Azure Kubernetes Services
Este material apresenta o módulo do Azure Kubernetes Services e suas entradas necessárias.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_log_analytics_solution.aks_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution) | resource |
| [azurerm_log_analytics_workspace.aks_wksp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_role_assignment.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.attach_acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [random_id.log_analytics_workspace_name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_string.aks](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_node](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_dns_ip"></a> [aks\_dns\_ip](#input\_aks\_dns\_ip) | IP do DNS (deve estar dentro do range de IP do `aks_network_cidr`). | `string` | n/a | yes |
| <a name="input_aks_docker_bridge"></a> [aks\_docker\_bridge](#input\_aks\_docker\_bridge) | endereço CIDR para ser usado como Docker Bridge. | `string` | n/a | yes |
| <a name="input_aks_network_cidr"></a> [aks\_network\_cidr](#input\_aks\_network\_cidr) | Endereço CIDR da rede do Kubernetes Service. | `string` | n/a | yes |
| <a name="input_node_subnet"></a> [node\_subnet](#input\_node\_subnet) | Subnet do default node. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nome do Resource Group. | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Nome da VNET | `string` | n/a | yes |
| <a name="input_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#input\_vnet\_resource\_group\_name) | Resource Group da rede virtual. | `string` | n/a | yes |
| <a name="input_acr_id"></a> [acr\_id](#input\_acr\_id) | ID do ACR a ser integrado com o AKS. | `string` | `""` | no |
| <a name="input_additional_node_pools"></a> [additional\_node\_pools](#input\_additional\_node\_pools) | O mapa de objetos para configurar um ou mais node pools adicinais com um número de VMs, seus sizes e Disponibilidade de zona. | <pre>map(object({<br>    additional_node_name           = string<br>    node_count                     = number<br>    vm_size                        = string<br>    zones                          = list(string)<br>    max_pods                       = number<br>    os_disk_size                   = number<br>    node_os                        = string<br>    cluster_auto_scaling           = bool<br>    cluster_auto_scaling_min_count = number<br>    cluster_auto_scaling_max_count = number<br>    enable_public_ip               = bool<br>  }))</pre> | `{}` | no |
| <a name="input_aks_network_plugin"></a> [aks\_network\_plugin](#input\_aks\_network\_plugin) | Nome do Network plugin usado pelo Kubernetes Services. Use `azure` para a rede avançada (Azure CNI) ou `kubenet` para a rede básica. | `string` | `"azure"` | no |
| <a name="input_aks_network_policy"></a> [aks\_network\_policy](#input\_aks\_network\_policy) | Nome da Network Policy usada pelo Kubernete Services. Utilize `azure`, `calico` ou `none`. | `string` | `"azure"` | no |
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | Application ID da service principal que irá governar o Kubernetes Service. | `string` | `null` | no |
| <a name="input_default_node_settings"></a> [default\_node\_settings](#input\_default\_node\_settings) | Configurações de `max_nodes` e `min_nodes` quando a opção `enable_autoscaling` está definida como `true`. | `map(any)` | `{}` | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | Node de DNS do cluster de Kubernetes. | `string` | `"service"` | no |
| <a name="input_enable_attach_acr"></a> [enable\_attach\_acr](#input\_enable\_attach\_acr) | Força o attach ou não do Kubernetes Services com o Azure Container Services (Obrigatório verificar a documentação adequada) | `bool` | `false` | no |
| <a name="input_enable_autoscaling"></a> [enable\_autoscaling](#input\_enable\_autoscaling) | Habilita ou não as opções de autoscaling do default node pool. | `bool` | `false` | no |
| <a name="input_enable_azure_active_directory"></a> [enable\_azure\_active\_directory](#input\_enable\_azure\_active\_directory) | Habilitar ou não Integração com Azure Active Directory. | `bool` | `false` | no |
| <a name="input_enable_azure_policy"></a> [enable\_azure\_policy](#input\_enable\_azure\_policy) | Habilitar ou não o add-on de Azure Policy para Kubernetes. | `bool` | `false` | no |
| <a name="input_enable_http_application_routing"></a> [enable\_http\_application\_routing](#input\_enable\_http\_application\_routing) | Habilitar ou não Roteamento HTTP de Aplicação. | `bool` | `true` | no |
| <a name="input_enable_log_analytics_workspace"></a> [enable\_log\_analytics\_workspace](#input\_enable\_log\_analytics\_workspace) | Habilita ou não o uso do Log Analytics. Neste momento não é possível associar a um Log Analytics Workspace existente. | `bool` | `false` | no |
| <a name="input_enable_monitoring_agent"></a> [enable\_monitoring\_agent](#input\_enable\_monitoring\_agent) | Uso legado para habilitar monitoramento. Vide linha 82 em main.tf do commit **[acdf68f8]**. | `bool` | `true` | no |
| <a name="input_enable_role_based_access_control"></a> [enable\_role\_based\_access\_control](#input\_enable\_role\_based\_access\_control) | Habilitar ou não RBAC para Kubernetes. | `bool` | `true` | no |
| <a name="input_host_encryption"></a> [host\_encryption](#input\_host\_encryption) | Habilita criptografia no default node pool | `bool` | `false` | no |
| <a name="input_is_identity_enabled"></a> [is\_identity\_enabled](#input\_is\_identity\_enabled) | Habilitar ou não o uso de identidade gerenciada. | `bool` | `false` | no |
| <a name="input_is_private_cluster_enabled"></a> [is\_private\_cluster\_enabled](#input\_is\_private\_cluster\_enabled) | Habilita que o cluster teha suas APIs dipostas somente para a rede interna | `bool` | `false` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Versão do Kubernetes para o Kubernetes Services. | `string` | `"1.19.9"` | no |
| <a name="input_location"></a> [location](#input\_location) | localidade em que será criado o Kubernetes Service. | `string` | `"westeurope"` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | nome do workspace do Log Analytics. É obrigatório caso `enable_log_analytics_workspace` for marcado como `true` | `string` | `null` | no |
| <a name="input_log_analytics_workspace_sku"></a> [log\_analytics\_workspace\_sku](#input\_log\_analytics\_workspace\_sku) | Define a SKU utilizada pelo Log Analytics Workspace. | `string` | `"PerGB2018"` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | Define o número de dias em que os logs serão armazenados no Workspace. | `number` | `30` | no |
| <a name="input_max_pods"></a> [max\_pods](#input\_max\_pods) | Quantidade máxima de Pods por node (dentro do Default node). | `number` | `30` | no |
| <a name="input_node_av_zone"></a> [node\_av\_zone](#input\_node\_av\_zone) | n/a | `list(number)` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Nome do Default node do Kubernetes Services. | `string` | `"default"` | no |
| <a name="input_node_vm_count"></a> [node\_vm\_count](#input\_node\_vm\_count) | Número de Nodes (VMs) que serão criados para o default node do Kubernetes Services. | `number` | `2` | no |
| <a name="input_node_vm_disk_size"></a> [node\_vm\_disk\_size](#input\_node\_vm\_disk\_size) | Tamanho em GB do disco de SO do Node | `number` | `30` | no |
| <a name="input_node_vm_size"></a> [node\_vm\_size](#input\_node\_vm\_size) | Size da VM do default node | `string` | `"Standard_d2s_v3"` | no |
| <a name="input_password"></a> [password](#input\_password) | Application Secret da service principal que irá governar o Kubernetes Services. | `string` | `null` | no |
| <a name="input_rbac_aad_admin_group_object_ids"></a> [rbac\_aad\_admin\_group\_object\_ids](#input\_rbac\_aad\_admin\_group\_object\_ids) | Object ID of groups with admin access. | `list(string)` | `null` | no |
| <a name="input_rbac_aad_managed"></a> [rbac\_aad\_managed](#input\_rbac\_aad\_managed) | Habilitar ou não gestão de RBAC de Azure AD Gerenciado. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapa de tags pra rotular os recursos do Kubernetes Services. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_addon_profile"></a> [addon\_profile](#output\_addon\_profile) | n/a |
| <a name="output_aks_cluster_name"></a> [aks\_cluster\_name](#output\_aks\_cluster\_name) | n/a |
| <a name="output_aks_dns_name"></a> [aks\_dns\_name](#output\_aks\_dns\_name) | n/a |
| <a name="output_identity"></a> [identity](#output\_identity) | n/a |
| <a name="output_kube_admin_config"></a> [kube\_admin\_config](#output\_kube\_admin\_config) | n/a |
| <a name="output_kube_config_raw"></a> [kube\_config\_raw](#output\_kube\_config\_raw) | n/a |

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

