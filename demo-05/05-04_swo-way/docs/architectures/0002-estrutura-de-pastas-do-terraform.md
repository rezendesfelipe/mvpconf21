# 2. Estrutura de pastas do Terraform

Data: 2021-11-10

## Status

Aceito

## Context

Precisamos definir em um modelo que atenda a boas práticas de desenvolvimento de Infraestrutura como Código.

## Decision

O modelo definido está seguindo algumas premissas que são importantes serem esclarecidas:

```
📦terraform (1)
 ┣ 📂.devcontainer (2)
 ┃ ┣ 📂library-scripts
 ┃ ┃ ┣ 📜azcli-debian.sh
 ┃ ┃ ┣ 📜common-debian.sh
 ┃ ┃ ┣ 📜docker-debian.sh
 ┃ ┃ ┣ 📜node-debian.sh
 ┃ ┃ ┗ 📜terraform-debian.sh
 ┃ ┣ 📜Dockerfile
 ┃ ┣ 📜devcontainer.env
 ┃ ┗ 📜devcontainer.json
 ┣ 📂cicd (3)
 ┃ ┣ 📂stages
 ┃ ┃ ┣ 📜stages-cd.yml
 ┃ ┃ ┗ 📜stages-ci.yml
 ┃ ┣ 📜cd.yml
 ┃ ┗ 📜ci.yml
 ┣ 📂modules (4)
 ┣ 📂stacks (5)
 ┃ ┣ 📂env (5.1)
 ┃ ┃ ┣ 📜dev.tfvars
 ┃ ┃ ┣ 📜prd.tfvars
 ┃ ┃ ┗ 📜qa.tfvars
 ┃ ┗ 📂stack1 (5.2)
 ┃ ┃ ┣ 📜locals.stack1.tf
 ┃ ┃ ┣ 📜module.vnet_stack1.tf
 ┃ ┃ ┣ 📜outputs.stack1.tf
 ┃ ┃ ┣ 📜resource.rg_stack1.tf
 ┃ ┃ ┗ 📜variables.stack1.tf
 ┣ 📂templates (6)
 ┃ ┗ 📜.tf-docs-readme.yml
 ┣ 📜.gitignore
 ┣ 📜Makefile 
 ┗ 📜README.md
```

### 1. terraform
Esta pasta conterá todos os documentos relacionados ao Terraform.

### 2. .devcontainer

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


### 3. cicd
Possui a estrutura de arquivos `.yml` que serão responsáveis pelos stages de CI e CD do ambiente. 

### 4. modules
Contém a construção generalizada dos componentes a serem provisionados. Todos os códigos para criação da Infraestrutura como código serão provisionados reciclando os módulos aqui contidos. Mais informações sobre como funcionam os módulos no terraform podem ser consultadas [**clicando neste link**](https://www.terraform.io/docs/language/modules/develop/index.html).

### 5. stacks
Aqui vamos apresentar a estrutura de pastas que será usada para efetivamente realizar a criação do ambiente.

#### 5.1 env
A pasta `env` possuirá os arquivos com variáveis de ambiente neste modelo: 
 - `dev.tfvars`
 - `prd.tfvars`

Estes arquivos serão consultados sob demanda através do pipeline de deployment.

#### 5.2 stack1 
As stacks são estruturas organizacionais que possuem a lógica de negócio usada para a construção do ambiente. Aqui é possível haver 1 ou mais diretórios cada um especificando uma estrutura organizacional independente.

> Não confundir o diretório **stack** com **env**

### 6. templates
Aqui ficam armazenados todos os templates de referência usados para todos o ambiente. Aqui teremos liberdade de criar sub-diretórios que contenham os arquivos de template necessários para evitar a repetição de referências.

## Consequences

Ao manter um modelo centralizado e padronizado de uso, o desenvolvimento se torna muito mais estruturado e claro. Caso um novo time assuma o desenvolvimento da infraestrutura, saberá claramente o propósito de cada um dos diretórios importantes deste projeto.