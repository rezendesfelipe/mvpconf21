# Lab-001 - Cenário de migração para Cloud
O laboratório 001 simula a orquestração de provisionamento de um ambiente on-premises em um ambiente automatizado na nuvem.

## Requisitos gerais

|Componente|Versão|
|--|--|
|`Azure CLI`| `latest`|
|`make`|`latest`|
|`terraform`|`>=1.0.7`|
|`ansible`|`>=2.7.7`|
|`terraform-docs`|`v0.15.0`|

Este laboratório utiliza a extensão de Dev Containers do Visual Studio Code para facilitar o desenvolvimento do ambiente. Basta utilizar a extensão e fazer o build da imagem e você estará pronto para uso.

Para dúvidas, consulte a referência oficial [**clicando aqui**](https://code.visualstudio.com/docs/remote/create-dev-container)
Para utilizar o ambiente remoto utilize esta extensão
[**Remote Containers**](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Por onde começar

Inicie sua sessão no azure usando o comando `az login --use-device-code` (recomendamos o uso do device code para facilitar o processo de logon.

Em seguida prepare o arquivo de [variáveis do ambiente](./bootstrap/env-vars.sh) usando o seguinte padrão:
``` shell
#!/bin/bash

set -e

export LOCATION=<Local onde está a storage account e keyvault> # eastus2
export COMMON_RESOURCE_GROUP_NAME=<Nome do Resource Group onde está a storage account e keyvault> # rg-ts-shared-prd
export TF_STATE_STORAGE_ACCOUNT_NAME=<Nome da Storage Account> # sacloudservicesprd
export TF_STATE_CONTAINER_NAME=<Nome do container da Storage Account> # terraform-state
export KEYVAULT_NAME=<Nome do Key Vaualt> # kv-cloudservices-prd
export LABNAME=<Nome do lab> # lab-001
```

Concluída esta etapa, você terá este ambiente 100% pronto para poder começar a desenvolver!

### Comandos para execução local

`make all`:
  * Atualiza o README.md do projeto
  * Atualiza o arquivo terraform.tfvars  
  * Faz o setup inicial das variables do Terraform
  * Inicializa o Terraform
  * Valida formatação do código
  * Valida sintaxe do código
  * Testa o plano de execução
  * Executa do plano de execução

`make create-environment`  
  * Cria do plano de execução
  * Executa do plano de execução


`make destroy-environment`
  * Cria o plano de destruição do ambiente
  * Executa o plano de destruição do ambiente

`make prepare-documentation`
  * Atualiza o `README.md` do projeto

`make prepare-tfvars`
  * Atualiza o arquivo de `terraform.tfvars`

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.77.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_migration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_onprem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username_hub"></a> [admin\_username\_hub](#input\_admin\_username\_hub) | Virtual Machine Administrator Default Name | `string` | `"azureuser"` | no |
| <a name="input_admin_username_migration"></a> [admin\_username\_migration](#input\_admin\_username\_migration) | n/a | `string` | `"azureuser"` | no |
| <a name="input_admin_username_onprem"></a> [admin\_username\_onprem](#input\_admin\_username\_onprem) | n/a | `string` | `"azureuser"` | no |
| <a name="input_lb_web_name_migration"></a> [lb\_web\_name\_migration](#input\_lb\_web\_name\_migration) | n/a | `string` | `"lb-web-migration"` | no |
| <a name="input_nsg_db_name_migration"></a> [nsg\_db\_name\_migration](#input\_nsg\_db\_name\_migration) | Nome da NSG db do ambiente de migração | `string` | `"nsg-db-migration"` | no |
| <a name="input_nsg_db_name_onprem"></a> [nsg\_db\_name\_onprem](#input\_nsg\_db\_name\_onprem) | n/a | `string` | `"nsg-db-onprem"` | no |
| <a name="input_nsg_mgmt_name_hub"></a> [nsg\_mgmt\_name\_hub](#input\_nsg\_mgmt\_name\_hub) | Nome da NSG mgmt do ambiente de migração | `string` | `"nsg-mgmt-hub"` | no |
| <a name="input_nsg_mgmt_name_migration"></a> [nsg\_mgmt\_name\_migration](#input\_nsg\_mgmt\_name\_migration) | Nome da NSG mgmt do ambiente de migração | `string` | `"nsg-mgmt-migration"` | no |
| <a name="input_nsg_mgmt_name_onprem"></a> [nsg\_mgmt\_name\_onprem](#input\_nsg\_mgmt\_name\_onprem) | n/a | `string` | `"nsg-mgmt-onprem"` | no |
| <a name="input_nsg_web_name_migration"></a> [nsg\_web\_name\_migration](#input\_nsg\_web\_name\_migration) | Nome da NSG web do ambiente de migração | `string` | `"nsg-web-migration"` | no |
| <a name="input_nsg_web_name_onprem"></a> [nsg\_web\_name\_onprem](#input\_nsg\_web\_name\_onprem) | n/a | `string` | `"nsg-web-onprem"` | no |
| <a name="input_public_key_hub"></a> [public\_key\_hub](#input\_public\_key\_hub) | Public SSH key used to be added as `authorized_keys` | `string` | `null` | no |
| <a name="input_public_key_migration"></a> [public\_key\_migration](#input\_public\_key\_migration) | Public SSH key used to be added as `authorized_keys` | `string` | `null` | no |
| <a name="input_public_key_onprem"></a> [public\_key\_onprem](#input\_public\_key\_onprem) | Public SSH key used to be added as `authorized_keys` | `string` | `null` | no |
| <a name="input_rg_location_hub"></a> [rg\_location\_hub](#input\_rg\_location\_hub) | Hub default resources location | `string` | `"eastus2"` | no |
| <a name="input_rg_location_migration"></a> [rg\_location\_migration](#input\_rg\_location\_migration) | Location where resources will be deployed. | `string` | `"eastus2"` | no |
| <a name="input_rg_location_onprem"></a> [rg\_location\_onprem](#input\_rg\_location\_onprem) | n/a | `string` | `"eastus2"` | no |
| <a name="input_rg_name_hub"></a> [rg\_name\_hub](#input\_rg\_name\_hub) | Hub Resource group name | `string` | `"rg-hub"` | no |
| <a name="input_rg_name_migration"></a> [rg\_name\_migration](#input\_rg\_name\_migration) | Name of the Resource Group | `string` | `"rg-migration"` | no |
| <a name="input_rg_name_onprem"></a> [rg\_name\_onprem](#input\_rg\_name\_onprem) | n/a | `string` | `"rg-onprem"` | no |
| <a name="input_tags_hub"></a> [tags\_hub](#input\_tags\_hub) | Tags used to identify Hub environment | `map(any)` | `{}` | no |
| <a name="input_tags_migration"></a> [tags\_migration](#input\_tags\_migration) | Map of tags using key-value syntax. | `map(string)` | `{}` | no |
| <a name="input_tags_onprem"></a> [tags\_onprem](#input\_tags\_onprem) | n/a | `map(any)` | `{}` | no |
| <a name="input_vm_db_setup_migration"></a> [vm\_db\_setup\_migration](#input\_vm\_db\_setup\_migration) | Describe Virtual Machine Features in a map. Map key is defined as vm\_name | `any` | <pre>{<br>  "vm-db-migration-0": {<br>    "vm_size": "Standard_B1ls"<br>  },<br>  "vm-db-migration-1": {<br>    "vm_size": "Standard_B1ls"<br>  },<br>  "vm-db-migration-2": {<br>    "vm_size": "Standard_B1ls"<br>  }<br>}</pre> | no |
| <a name="input_vm_db_setup_onprem"></a> [vm\_db\_setup\_onprem](#input\_vm\_db\_setup\_onprem) | Describe Virtual Machine Features in a map. Map key is defined as vm\_name | `any` | <pre>{<br>  "vm-db-onprem-0": {<br>    "vm_size": "Standard_B1ls"<br>  },<br>  "vm-db-onprem-1": {<br>    "vm_size": "Standard_B1ls"<br>  },<br>  "vm-db-onprem-2": {<br>    "vm_size": "Standard_B1ls"<br>  }<br>}</pre> | no |
| <a name="input_vm_mgmt_hub_enable_public_ip"></a> [vm\_mgmt\_hub\_enable\_public\_ip](#input\_vm\_mgmt\_hub\_enable\_public\_ip) | Define if management VM should have public IP Address | `bool` | `true` | no |
| <a name="input_vm_mgmt_name_hub"></a> [vm\_mgmt\_name\_hub](#input\_vm\_mgmt\_name\_hub) | Nome da VM de Management | `string` | `"vm-mgmt-hub"` | no |
| <a name="input_vm_mgmt_name_migration"></a> [vm\_mgmt\_name\_migration](#input\_vm\_mgmt\_name\_migration) | Nome da Vm de gerência de Migration | `string` | `"vm-mgmt-migration"` | no |
| <a name="input_vm_mgmt_name_onprem"></a> [vm\_mgmt\_name\_onprem](#input\_vm\_mgmt\_name\_onprem) | n/a | `string` | `"vm-mgmt-onprem"` | no |
| <a name="input_vm_mgmt_size_hub"></a> [vm\_mgmt\_size\_hub](#input\_vm\_mgmt\_size\_hub) | Size da VM de Management | `string` | `"Standard_B1ls"` | no |
| <a name="input_vm_mgmt_size_migration"></a> [vm\_mgmt\_size\_migration](#input\_vm\_mgmt\_size\_migration) | Size da Vm de gerência de Migration | `string` | `"Standard_B1ls"` | no |
| <a name="input_vm_mgmt_size_onprem"></a> [vm\_mgmt\_size\_onprem](#input\_vm\_mgmt\_size\_onprem) | n/a | `string` | `"Standard_B1ls"` | no |
| <a name="input_vm_web_setup_migration"></a> [vm\_web\_setup\_migration](#input\_vm\_web\_setup\_migration) | Describe Virtual Machine Features in a map. Map key is defined as vm\_name | `any` | <pre>{<br>  "vm-web-migration-0": {<br>    "vm_size": "Standard_B1ls"<br>  },<br>  "vm-web-migration-1": {<br>    "vm_size": "Standard_B1ls"<br>  }<br>}</pre> | no |
| <a name="input_vm_web_setup_onprem"></a> [vm\_web\_setup\_onprem](#input\_vm\_web\_setup\_onprem) | Describe Virtual Machine Features in a map. Map key is defined as vm\_name | `any` | <pre>{<br>  "vm-web-onprem-0": {<br>    "vm_size": "Standard_B1ls"<br>  },<br>  "vm-web-onprem-1": {<br>    "vm_size": "Standard_B1ls"<br>  }<br>}</pre> | no |
| <a name="input_vnet_address_space_hub"></a> [vnet\_address\_space\_hub](#input\_vnet\_address\_space\_hub) | Address Space of the hub virtual network | `list(string)` | <pre>[<br>  "172.16.0.0/22"<br>]</pre> | no |
| <a name="input_vnet_address_space_migration"></a> [vnet\_address\_space\_migration](#input\_vnet\_address\_space\_migration) | List of all Virtual Network Ranges. | `list(string)` | <pre>[<br>  "192.168.0.0/16"<br>]</pre> | no |
| <a name="input_vnet_address_space_onprem"></a> [vnet\_address\_space\_onprem](#input\_vnet\_address\_space\_onprem) | n/a | `list(string)` | <pre>[<br>  "10.1.0.0/16"<br>]</pre> | no |
| <a name="input_vnet_name_hub"></a> [vnet\_name\_hub](#input\_vnet\_name\_hub) | Name of the hub virtual network | `string` | `"vnet-hub"` | no |
| <a name="input_vnet_name_migration"></a> [vnet\_name\_migration](#input\_vnet\_name\_migration) | Name of the virtual Network. Meaning that will be only one, for now. | `string` | `"vnet-migration"` | no |
| <a name="input_vnet_name_onprem"></a> [vnet\_name\_onprem](#input\_vnet\_name\_onprem) | n/a | `string` | `"onprem-vnet"` | no |
| <a name="input_vnet_subnets_hub"></a> [vnet\_subnets\_hub](#input\_vnet\_subnets\_hub) | Hub Subnet configurations | `any` | <pre>{<br>  "GatewaySubnet": {<br>    "address_prefix": "172.16.3.224/27"<br>  },<br>  "subnet_mgmt": {<br>    "address_prefix": "172.16.0.0/24"<br>  }<br>}</pre> | no |
| <a name="input_vnet_subnets_migration"></a> [vnet\_subnets\_migration](#input\_vnet\_subnets\_migration) | Migration subnet setup | `any` | <pre>{<br>  "subnet_db": {<br>    "address_prefix": "192.168.4.0/27"<br>  },<br>  "subnet_mgmt": {<br>    "address_prefix": "192.168.0.0/27"<br>  },<br>  "subnet_web": {<br>    "address_prefix": "192.168.2.0/27"<br>  }<br>}</pre> | no |
| <a name="input_vnet_subnets_onprem"></a> [vnet\_subnets\_onprem](#input\_vnet\_subnets\_onprem) | n/a | `any` | <pre>{<br>  "subnet_db": {<br>    "address_prefix": "10.1.2.0/24"<br>  },<br>  "subnet_mgmt": {<br>    "address_prefix": "10.1.0.0/24"<br>  },<br>  "subnet_web": {<br>    "address_prefix": "10.1.1.0/24"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_ip_webserver_onprem"></a> [private\_ip\_webserver\_onprem](#output\_private\_ip\_webserver\_onprem) | n/a |
| <a name="output_private_ip_webservers_onprem"></a> [private\_ip\_webservers\_onprem](#output\_private\_ip\_webservers\_onprem) | n/a |
| <a name="output_public_ip_ansible_onprem"></a> [public\_ip\_ansible\_onprem](#output\_public\_ip\_ansible\_onprem) | n/a |

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

