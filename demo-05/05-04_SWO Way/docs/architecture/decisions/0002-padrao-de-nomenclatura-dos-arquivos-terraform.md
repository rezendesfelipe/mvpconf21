# 2. padrão de nomenclatura dos arquivos terraform

Date: 2021-10-06

## Status

Proposed

## Context

Precisamos de um modelo fácil e escalável de preparação de documentos terraform

## Decision

Os documentos serão divididos seguindo o padrão `<tipo>.<componente>_<função>_<ambiente>`;

Importante observar que obrigatoriamente deve ser usado padrão `snake_case` para nomear os arquivos, substituindo espaços exclusivamente por `_`.

Por exemplo: `module.ilb_db_onprem` => Módulo que cria um Internal Load Balancer dos servidores de Database do ambiente Onpremises

Para a decisão completa segue a lista proposta:

|Tipo|Padrão|Exemplo|
|--|--|--|
|`Módulo`|`module.<componente>_<função>_<ambiente>.tf`|`module.vm_web_migration.tf`|
|`Recurso`|`resource.<componente>_<função>_<ambiente>.tf` // `resource.<componente>_<ambiente>.tf` |`resource.rg_onprem.tf` // `resource.rt_web_migration.tf` |
|`Locals`|`locals.<ambiente>.tf`|`locals.on_prem.tf`|
|`Variables`|`variables.<ambiente>.tf`|`variables.hub.tf`|
|`Outputs`|`outputs.<ambiente>`|`outputs.hub.tf`|
|`Backend`|`backend.tf`|`N/A`|
|`Providers`|`providers.tf`| `N/A`|
|`Terraform Vars`|`terraform.tfvars`|`N/A`|

## Consequences

Torna-se muito mais fácil de identificar do que se trata o documento em questão e habilita que múltiplas pessoas tenham independência em trabalhar em determinados componentes quando deixamos cada documento cuidando de um componente separadamente.