# Módulo de Service-Bus
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `name`: Especifica o nome do recurso de namespace ServiceBus. 
* [Obrigatório] `location`:Especifica o local do Azure com suporte onde o recurso existe.
* [Obrigatório] `sku`: Define qual camada usar. As opções são básicas, padrão ou premium.

* [Opcional] `capacity`: Especifica a capacidade. Quando sku é Premium, a capacidade pode ser 1, 2, 4, 8 ou 16. Quando sku é Basic ou Standard, a capacidade pode ser 0 apenas.
* [Opcional] `zone_redundant`: Se este recurso é ou não redundante de zona. skuprecisa ser Premium. O padrão é false.


## Exemplo de uso
Terraform 0.14.x
``` Go
module "service-bus" {
  source = "../terraform-cloud/modules/service-bus"

  resource_group_name = module.rg.rg_name
  sku_name            = "Standard"
  namespace_name        = "newnamespaceexample"
  depends_on            = [module.rg]
}
```

### Exemplo de plan

terraform plan -target module.service-bus