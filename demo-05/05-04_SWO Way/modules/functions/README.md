# Módulo de Azure Functions
## Variáveis válidas (App Services Plan)
Este módulo aceita as seguintes variáveis
* [Obrigatório] `name`: Nome do plano do app services a ser criado. Será utilizado posteriormente no Function App.
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado. O padrão é fazer uso do resource group de sua vertical (Ex: Impulse)
* [Obrigatório] `kind`: O tipo suportado pelo plano (FunctionApp, linux, container). O valor padrão é `FunctionApp`.
* [Obrigatório] `tier`: Tipo de camada do plano (Free, Shared, Basic, Standard, Premium, PremiumV2, PremiumV3, Isolated, Dynamic). Padrão é `Standard`.
* [Obrigatório] `Size`: Qual performance é esperada ( B1, B2, B3, D1, F1, FREE, I1, I1v2, I2, I2v2, I3, I3v2, P1V2, P1V3, P2V2, P2V3, P3V2, P3V3, PC2, PC3, PC4, S1, S2, S3, SHARED, Y1). Padrão é `B1`.

Ref: https://docs.microsoft.com/en-us/cli/azure/appservice/plan?view=azure-cli-latest

* [Opcional] `tags`: Quais tags serão utilizados. Normalmente ele já irá puxar no momento em que o módulo for chamado.

## Variáveis válidas (Function Apps)

* [Obrigatório] `name`: Nome do plano do app services a ser criado. Será utilizado posteriormente no Function App.
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado. O padrão é fazer uso do resource group de sua vertical (Ex: Impulse)
* [Obrigatório] `storage_account_name`: Nome da storage account.
* [Obrigatório] `storage_account_key`: Primary Key da storage account.
* [Opcional] `tags_apps`: Quais tags serão utilizados. Normalmente ele já irá puxar no momento em que o módulo for chamado.
## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "app-func-test"{
  source = "../../../module/functions"
  resource_group_name = module.rg.rg_name
  produto =  var.produto
  ambiente = var.ambiente
  vertical = var.vertical
  location = var.location
  tags_apps = var.tags_apps
  func_plan_sku_tier = var.func_plan_sku_tier
  func_plan_sku_size = var.func_plan_sku_size

  func_apps={
        "teste-app" = zipmap(["storage_name", "storage_primary_access_key"], [module.stg-importerflow.storage_account_name.stg_importerflow_name, module.stg-importerflow.storage_access_key.primary_access_key])
  }
}
```
