# Módulo de Azure Container Instance (ACI)
## Variáveis válidas (Globais)
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado. O padrão é fazer uso do resource group de sua vertical (Ex: Commerce)
* [Obrigatório] `location`: Localidade onde a VM será criada. O valor padrão é `eastus2`.
* [Opcional] `tags`: Quais tags serão utilizados. Normalmente ele já irá puxar no momento em que o módulo for chamado.

## Variáveis válidas (ACI Group)
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado. O padrão é fazer uso do resource group de sua vertical (Ex: Impulse)

Um exemplo de como pode ser realizado:
``` Go
  resource_group_name = module.rg.rg_name
```
* [Obrigatório] `location`: Localidade onde a VM será criada. O valor padrão é `eastus2`.
* [Obrigatório] `aci_os`: Parâmetro que define qual sistema operacional será utilizado para os containers. Valores válidos: `linux` e `windows`.


## Variáveis válidas (ACI Container)

* [Obrigatório] `v_container`: Se trata de uma lista com 1 ou mais containers para um mesmo grupo.
Modelo:
``` Go
 v_container = { teste1 = {
    name  = "cont-teste1"
    image = "microsoft/aci-tutorial-sidecar"
    cpu   = "2.0"
    memory   = "4.0"
    },teste2 = {
    name  = "cont-teste2"
    image = "microsoft/aci-tutorial-sidecar"
    cpu   = "2.0"
    memory   = "4.0"
    }
  }
```
* [Obrigatório] `name`: Nome do container"
* [Obrigatório] `image`: imagem a ser utilizada no container. (Ex: o.5 , 1.0 (1 Core))
* [Obrigatório] `cpu`: Quantidade de CPU para o container (Ex: o.5 (500 Mb), 1.0 (1GB))
* [Obrigatório] `memory`: Quantidade de memória para o container (Ex: o.5 (500 Mb), 1.0 (1GB)) 



## Outputs

Para fazer a chamada dos outputs será preciso chama-los no arquivo outputs.tf do diretório do produto.
Modelo:
``` Go

output "aci-group_id" {
  value       = module.aci.aci-group_id
  description = "Azure container instance group ID"
}

output "aci-group_ip_address" {
  value       = module.aci.aci-group_ip_address
  description = "The IP address allocated to the container instance group."
}

output "aci-group_fqdn" {
  value       = module.aci.aci-group_fqdn
  description = "The FQDN of the container group derived from `dns_name_label`."
}

```
## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "aci" {
  source = "./modules/aci"

  aci_grp_name        = "aci-grp-lab"
  resource_group_name = module.rg.rg_name
  location            = "eastus2"
  aci_os              = "windows"

  v_container = { teste1 = {
    name  = "cont-teste1"
    image = "microsoft/aci-tutorial-sidecar"
    cpu   = "2.0"
    memory   = "4.0"
    },teste2 = {
    name  = "cont-teste2"
    image = "microsoft/aci-tutorial-sidecar"
    cpu   = "2.0"
    memory   = "4.0"
    }
  }

    depends_on = [module.rg]
}
```

``` Go
Terraform will perform the following actions:

  # module.aci.azurerm_container_group.aci will be created
  + resource "azurerm_container_group" "aci" {
      + exposed_port        = (known after apply)
      + fqdn                = (known after apply)
      + id                  = (known after apply)
      + ip_address          = (known after apply)
      + ip_address_type     = "Public"
      + location            = "eastus2"
      + name                = (known after apply)
      + os_type             = "Linux"
      + resource_group_name = "rg-commerce-linx-io-dev"
      + restart_policy      = "Always"

      + container {
          + commands = (known after apply)
          + cpu      = 2
          + image    = "microsoft/aci-tutorial-sidecar"
          + memory   = 4
          + name     = "cont-teste1"
        }
      + container {
          + commands = (known after apply)
          + cpu      = 2
          + image    = "microsoft/aci-tutorial-sidecar"
          + memory   = 4
          + name     = "cont-teste2"
        }

      + identity {
          + identity_ids = (known after apply)
          + principal_id = (known after apply)
          + type         = (known after apply)
        }
    }

  # module.aci.random_string.aci will be created
  + resource "random_string" "aci" {
      + id          = (known after apply)
      + length      = 4
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + result      = (known after apply)
      + special     = false
      + upper       = true
    }

```
