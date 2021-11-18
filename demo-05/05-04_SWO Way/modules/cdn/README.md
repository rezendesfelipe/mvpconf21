[Clique para voltar à lista de Módulos](../../README.md)

# Módulo de CDN
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `location`: Local onde será criado o perfil CDN.
* [Obrigatório] `sku`: Qual SKU será usada por este perfil de CDN. Valores aceitos `Standard_Akamai`, `Standard_ChinaCdn`, `Standard_Microsoft`, `Standard_Verizon` or `Premium_Verizon`. Padrão está definido como `Standard_Microsoft`.
* [Obrigatório] `cdn_profile_name`: Nome do perfil CDN. Se deseja criar mais de 1 perfil, este módulo precisa ser chamado mais de uma vez.
* [Obrigatório] `cdn_endpoint`: Configuração do endpoint a ser criado.
  * `endpoint_name`: Automaticamente receberá um valor aleatório de 4 dígitos junto do nome definido por você. O nome do endpoint automaticamente recebe o sufixo `*.azureedge.net`.
  * `cdn_origin_hostname`: url que deve ser considerada. (ex: `"www.site.com.br"`)
  * `cdn_origin_path`: diretório no qual deve-se realizar o caching (ex: _`/images`_. caso não haja nada defina como `null`) 
  * exemplo de uso: 
  ``` HCL
  cdn = {
      endpoint_name       = "cdn"
      cdn_origin_hostname = "cdn.percycle.com"
      cdn_origin_path     = null
    }
  ```
* _[REMOVIDO] `cdn_origin_hostname`: Lista de strings que determina o hostname/IP do Servidor de Origem. Exemplo: `["www.webpage.com"]`_
* [Opcional] `cdn_caching_behavior`: Configura comportamento de caching para query string. Aceita os valores `IgnoreQueryString`, `BypassCaching` e `UseQueryString`. Caso esteja usando perfil Premium da Verizon, é possível configurar também como `NotSet`. Padrão está definido como `IgnoreQueryString`. Importante: Se você for utilizar este valor para múltiplos endpoints e quiser ter comportamentos diferentes para cada endpoint, você deve fazer uma chamada manual para cada endpoint.
* [Opcional] `cdn_origin_path`: Lista de Strings que define caminho de cache. Default está definido como `["/"]`.
* [Opcional] `tags`: Quais tags serão utilizados. Normalmente ele já irá puxar no momento em que o módulo for chamado.
---
## Outputs do módulo
Este módulo produz os seguintes outputs: 
* `cdn_endpoint_ids`: Id do(s) endpoint(s) criado(s).
* `cdn_profile_id`: Id do profile criado. 
## Exemplo de uso
Terraform 0.14.x
``` Go
[...]
module "cdn" {
  source              = "../../../../modules/cdn"
  cdn_profile_name    = "cdn-produto-prd"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "global"
  tags                = merge({ role = "cdn" }, var.tags)
  sku                 = "Standard_Akamai"
  cdn_endpoint = {
    cdn = {
      endpoint_name       = "cdn"
      cdn_origin_hostname = "cdn.percycle.com"
      cdn_origin_path     = null
    }
  }
  depends_on = [
    azurerm_resource_group.rg
  ]
}
```

## Exemplo de Plan

<details><summary>Expanda para ver o exemplo</summary>

``` bash
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus2"
      + name     = "rg-validation"
      + tags     = {
          + "env"   = "dev"
          + "owner" = "Carlos Oliveira"
        }
    }

  # module.cdn.data.azurerm_resource_group.cdn will be read during apply
  # (config refers to values not yet known)
 <= data "azurerm_resource_group" "cdn"  {
      + id       = (known after apply)
      + location = (known after apply)
      + name     = "rg-validation"
      + tags     = (known after apply)

      + timeouts {
          + read = (known after apply)
        }
    }

  # module.cdn.azurerm_cdn_endpoint.cdn["cdn"] will be created
  + resource "azurerm_cdn_endpoint" "cdn" {
      + content_types_to_compress     = (known after apply)
      + host_name                     = (known after apply)
      + id                            = (known after apply)
      + is_http_allowed               = true
      + is_https_allowed              = true
      + location                      = "global"
      + name                          = (known after apply)
      + origin_host_header            = "cdn.percycle.com"
      + origin_path                   = (known after apply)
      + probe_path                    = (known after apply)
      + profile_name                  = "cdn-produto-prd"
      + querystring_caching_behaviour = "IgnoreQueryString"
      + resource_group_name           = "rg-validation"

      + origin {
          + host_name  = "cdn.percycle.com"
          + http_port  = 80
          + https_port = 443
          + name       = "endpoint-origin"
        }
    }

  # module.cdn.azurerm_cdn_profile.cdn will be created
  + resource "azurerm_cdn_profile" "cdn" {
      + id                  = (known after apply)
      + location            = "global"
      + name                = "cdn-produto-prd"
      + resource_group_name = "rg-validation"
      + sku                 = "Standard_Akamai"
      + tags                = {
          + "env"   = "dev"
          + "owner" = "Carlos Oliveira"
          + "role"  = "cdn"
        }
    }

  # module.cdn.random_string.cdn will be created
  + resource "random_string" "cdn" {
      + id          = (known after apply)
      + length      = 4
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = false
      + result      = (known after apply)
      + special     = false
      + upper       = true
    }

Plan: 4 to add, 0 to change, 0 to destroy.
```
</details>