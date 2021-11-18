[Voltar para o Menu Inicial](../README.md)
# Módulo de Application gateway
## Variáveis válidas (Work in progress)
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `vnet_name`: Nome da Rede virtual.
* [Obrigatório] `subnet_name`: Nome da subnet onde sera vinculado o app gateway. Utilize o módulo [VNET](..\vnet\readme.md)
* [Obrigatório] `sku`: Qual SKU do App gateway será usada. Valores aceitos incluem `Standard_Small`, `Standard_Medium`, `Standard_Large`, `Standard_v2`, `WAF_Medium`, `WAF_Large`, e `WAF_v2`.
* [Opcional] `ip_sku`: Qual é o tipo de SKU de IP Público usado para o Application Gateway. Aceita os termos `Static` e `Dynamic`.
* [Opcional] `capacity`: Capacidade de escala da SKU a ser usada pelo Application Gateway. Quando estiver como SKU 'v1' este valor precisa ser entre `1` e `32`, caso seja v2, os valores são de `1` a `125`.
* [Opcional] `tier`: Tier da SKU usada pelo Application Gateway. Valores aceitos incluem `Standard`, `Standard_v2`, `WAF` e `WAF_v2`.
* [Opcional] `tags`: Quais tags serão utilizados. Normalmente ele já irá puxar no momento em que o módulo for chamado.

## Exemplo de uso
Terraform 0.14.x
``` HCL
module "appgw-raas-batch" {
  source                   = "../../../../modules/app-gateway"
  resource_group_name      = "rg-platform-dev"
  vnet_resource_group_name = "rg-shared-dev"
  appgw_name               = "appgw-platform-raas-batch-dev"
  vnet_name                = "vnet-impulse-dev"
  subnet_name              = "subnet-platform-appgw"
  sku                      = "Standard_v2"
  tier                     = "Standard_v2"
  capacity                 = 1
  tags = {
    team        = "platform"
    suite       = "impulse"
    product     = "platform"
    env         = "dev"
    provisioner = "terraform"
  }
  is_public_ip_enabled = true
  frontends = [
    {
      name                 = "fe-public"
      is_public_ip_enabled = true
      private_ip_address   = null
    },
    {
      name                 = "fe-private"
      is_public_ip_enabled = false
      private_ip_address   = "10.8.14.6"
    }
  ]
  frontend_ports = [
    {
      name = "fe-private-443"
      port = 443
    },
    {
      name = "fe-private-80"
      port = 80
    }
  ]
  http_listener = [
    {
      name                           = "listener-private-80"
      frontend_ip_configuration_name = "fe-private"
      frontend_port_name             = "fe-private-80"
      ssl_certificate_name           = null
      protocol                       = "Http"
      host_name                      = null
      require_sni                    = null
    }
  ]

  probes = [
    {
      name                                      = "probe-default"
      host                                      = null
      interval                                  = 20
      path                                      = "/raas/admin/status"
      protocol                                  = "Http"
      timeout                                   = 20
      unhealthy_threshold                       = 4
      pick_host_name_from_backend_http_settings = true
    }
  ]

  backend_address_pool = ["be-raas-batch", "be-raas-online"]

  backend_http_settings = [
    {
      name                                = "httpsetting-default"
      cookie_based_affinity               = "Disabled"
      affinity_cookie_name                = null
      probe_name                          = "probe-default"
      path                                = null
      port                                = 80
      protocol                            = "Http"
      request_timeout                     = 20
      host_name                           = null
      pick_host_name_from_backend_address = true
    }
  ]

  rules = [
    {
      name                        = "rule-default"
      rule_type                   = "PathBasedRouting"
      http_listener_name          = "listener-private-80"
      backend_address_pool_name   = null
      backend_http_settings_name  = null
      redirect_configuration_name = null
      url_path_map_name           = "map-test"
    }
  ]

  ssl_certificate = []

  url_path_map = [
    {
      name                                = "map-test"
      default_backend_address_pool_name   = "be-raas-batch"
      default_backend_http_settings_name  = "httpsetting-default"
      default_redirect_configuration_name = null
      path_rules = [
        {
          name                        = "rule-test"
          paths                       = ["/test*"]
          backend_address_pool_name   = "be-raas-online"
          backend_http_settings_name  = "httpsetting-default"
          redirect_configuration_name = null
        },
        {
          name                        = "rule-redirection"
          paths                       = ["/redirect*"]
          backend_address_pool_name   = null
          backend_http_settings_name  = null
          redirect_configuration_name = "redirect-test"
        }
      ]
    }
  ]

    redirect_configurations = [
    {
      name                 = "redirect-test"
      redirect_type        = "Permanent"
      target_listener_name = null
      target_url           = "https://www.linx.com.br/"
      include_path         = false
      include_query_string = false
    }
  ]

}
```