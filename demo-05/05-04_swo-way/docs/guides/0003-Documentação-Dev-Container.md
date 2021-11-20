# 3. Como utilizar o Development Container

A tecnologia utilizada precisa que algumas variáveis sejam preenchidas corretamente para poder funcionar. Os arquivos que contém essas variáveis estão dentro da pasta ```.devcontainer```, na seguinte estrutura:

```
📦terraform
 ┗ 📂.devcontainer
```

## Variáveis

O conjunto de variáveis está no arquivo ```devcontainer.env```. Elas devem ser preenchidas da seguinte maneira:

- ARM_SUBSCRIPTION_ID -> A subscription / assinatura do Azure que será utilizada;

- TF_BACKEND_RESOURCE_GROUP -> O nome do grupo de recursos onde a storage account para o backend deve ser criada

- TF_BACKEND_LOCATION -> A região onde o grupo de recursos para o backend deve ser criado

- TF_BACKEND_STORAGE_ACCOUNT -> O nome da storage account para o backend

- TF_BACKEND_CONTAINER -> O nome do contêiner da storage account para o backend

- TF_BACKEND_KEY -> O nome do container blob da storage account do backend

- TF_VAR_RG_NAME -> Variável do projeto de teste: o nome do grupo de recursos a ser provisionado com o terraform

- SERVICE_PRINCIPAL_NAME -> Service Principal responsável por executar o ambiente Terraform do MVP Conf

- KEY_VAULT_NAME -> Nome do Key Vault

- ARM_TENANT_ID -> ID do Tenant

- ARM_CLIENT_ID -> Client ID da Service Principal

- ARM_CLIENT_SECRET -> Client Secret da Service Principal

- TF_ACCESS_KEY -> Access Key da Storage Account

## Features

Algumas features também são necessárias com características específicas para o funcionamento da aplicação dentro dos padrões esperados.

### Pacotes do Container

- Terraform na versão 1.0.10;
- TFLint na versão 0.33.1;
- Terraform-docs na versão 0.16.0.

### Extensões do Visual Studio Code

As extensões a seguir, representadas por seus IDs, estarão instaladas no container para ajudar no desenvolvimento:

- hashicorp.terraform;
- ms-vscode.azurecli;
- ms-azuretools.vscode-docker;
- ms-vsliveshare.vsliveshare;
- ms-vscode-remote.vscode-remote-extensionpack;
- redhat.ansible;
- eamodio.gitlens;
- pkief.material-icon-theme.