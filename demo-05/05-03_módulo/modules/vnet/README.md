# Módulo de Storage Account
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `vnet_name `: Nome da Rede virtual.
* [Obrigatório] `location`: Localização do location da vnet.
* [Obrigatório] `subnet_names`: Nome das subnets ex:["subnet1", "subnet2", "subnet3"].
* [Obrigatório] `subnet_prefixes`: Lista de ranges das subnets.
* [Obrigatório] `location`: Localização do location da vnet.
* [Opcional] `tags`: Quais tags serão utilizados. Normalmente ele já irá puxar no momento em que o módulo for chamado.

## Ouputs gerados pelo módulo
* `vnet_id`: The id of the newly created vNet.
* `vnet_name`: The Name of the newly created vNet.
* `vnet_location`: The location of the newly created vNet.
* `vnet_address_space`: The address space of the newly created vNet.
* `vnet_subnet_ids`: The ids of subnets created inside the newly created vNet.

## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "vnet" {
  source = "../terraform-cloud/modules/vnet"
  
  vnet_name             = "newavnet"
  resource_group_name   = module.rg.rg_name
  address_space         = ["10.0.0.0/16"]
  location              = module.rg.rg_location
  subnet_names          = ["subnet1", "subnet2", "subnet3"]
  subnet_prefixes       =  ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  depends_on            = [module.rg]
   tags = {
    Owner = ""
  }
}