# Azure Application Gateway
Este módulo traz as entradas e necessárias para criação de um Application Gateway.



## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_public_ip.appgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_user_assigned_identity.identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_resource_group.appgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.appgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.appgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appgw_name"></a> [appgw\_name](#input\_appgw\_name) | Nome do Application Gateway. | `string` | n/a | yes |
| <a name="input_backend_address_pool"></a> [backend\_address\_pool](#input\_backend\_address\_pool) | Define quais são os nomes dos backend address pools. | `list(string)` | n/a | yes |
| <a name="input_backend_http_settings"></a> [backend\_http\_settings](#input\_backend\_http\_settings) | Define as configurações de HTTP dos backends do Application Gateway. | <pre>list(object({<br>    name                                = string<br>    cookie_based_affinity               = string<br>    affinity_cookie_name                = string<br>    path                                = string<br>    port                                = number<br>    probe_name                          = string<br>    protocol                            = string<br>    request_timeout                     = number<br>    host_name                           = string<br>    pick_host_name_from_backend_address = bool<br>  }))</pre> | n/a | yes |
| <a name="input_frontend_ports"></a> [frontend\_ports](#input\_frontend\_ports) | Define a porta de front-end a ser usada pelo Application Gateway. Deve ser `80` ou `443`. | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | n/a | yes |
| <a name="input_frontends"></a> [frontends](#input\_frontends) | Insere as configurações de frontend do Application Gateway. | <pre>list(object({<br>    name                 = string<br>    is_public_ip_enabled = bool<br>    private_ip_address   = string<br>  }))</pre> | n/a | yes |
| <a name="input_http_listener"></a> [http\_listener](#input\_http\_listener) | Define as configurações de Listener do Application Gateway. | <pre>list(object({<br>    name                           = string<br>    frontend_ip_configuration_name = string<br>    frontend_port_name             = string<br>    ssl_certificate_name           = string<br>    protocol                       = string<br>    host_name                      = string<br>    require_sni                    = string<br>  }))</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Localização dos recursos a serem provisionados e localizados. | `string` | n/a | yes |
| <a name="input_probes"></a> [probes](#input\_probes) | Define as configurações de Health Probe do Application Gateway. | <pre>list(object({<br>    name                                      = string<br>    host                                      = string<br>    interval                                  = number<br>    path                                      = string<br>    protocol                                  = string<br>    timeout                                   = number<br>    unhealthy_threshold                       = number<br>    pick_host_name_from_backend_http_settings = bool<br>  }))</pre> | n/a | yes |
| <a name="input_redirect_configurations"></a> [redirect\_configurations](#input\_redirect\_configurations) | Define o tipo e configurações de redirecionamento do Application Gateway. | <pre>list(object({<br>    name                 = string<br>    redirect_type        = string<br>    target_listener_name = string<br>    target_url           = string<br>    include_path         = bool<br>    include_query_string = bool<br>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nome do Resource Group do Application Gateway. | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | Define as regras de roteamento do Application Gateway. | <pre>list(object({<br>    name                        = string<br>    rule_type                   = string<br>    http_listener_name          = string<br>    backend_address_pool_name   = string<br>    backend_http_settings_name  = string<br>    redirect_configuration_name = string<br>    url_path_map_name           = string<br>  }))</pre> | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Nome da subnet para inserir o Application Gateway. | `string` | n/a | yes |
| <a name="input_url_path_map"></a> [url\_path\_map](#input\_url\_path\_map) | Define configurações de Encaminhamento de URL baseado em path. | <pre>list(object({<br>    name                                = string<br>    default_backend_address_pool_name   = string<br>    default_backend_http_settings_name  = string<br>    default_redirect_configuration_name = string<br>    path_rules = list(object({<br>      name                        = string<br>      paths                       = list(string)<br>      backend_address_pool_name   = string<br>      backend_http_settings_name  = string<br>      redirect_configuration_name = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Nome da Rede Virtual a ser localizada. | `string` | n/a | yes |
| <a name="input_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#input\_vnet\_resource\_group\_name) | Nome do Resource Group da Rede Virtual. | `string` | n/a | yes |
| <a name="input_autoscale_max_capacity"></a> [autoscale\_max\_capacity](#input\_autoscale\_max\_capacity) | Define as configurações de Capacity do Autoscaling configurando a capacidade máxima do Application Gateway. | `number` | `null` | no |
| <a name="input_autoscale_min_capacity"></a> [autoscale\_min\_capacity](#input\_autoscale\_min\_capacity) | Define as configurações de Capacity do Autoscaling configurando a capacidade mínima do Application Gateway. | `number` | `null` | no |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | A configuração de capacidade da SKU a ser usada pelo Application Gateway. Quando estiver usando uma SKU v1 este valor precisa ser entre `1` e `32`, e quando for uma SKU v2 precisa ser entre `1` to `125`. Esta propriedade é opcional se a variavel `is_autoscale_enabled` está marcada como `true`. | `number` | `2` | no |
| <a name="input_gateway_ip_configurations"></a> [gateway\_ip\_configurations](#input\_gateway\_ip\_configurations) | Nome das configurações de frontend. | `list(string)` | <pre>[<br>  "appGwPublicFrontendIp",<br>  "appGwPrivateFrontendIp"<br>]</pre> | no |
| <a name="input_ip_sku"></a> [ip\_sku](#input\_ip\_sku) | Tipo de alocação de IP Público que deve ser atribuído ao Application Gateway. Aceita os valores `Static` para alocação fixa e `Dynamic` para alocação dinâmica | `string` | `"Static"` | no |
| <a name="input_is_autoscale_enabled"></a> [is\_autoscale\_enabled](#input\_is\_autoscale\_enabled) | Ajusta se deve ou não ser utilizado Autoscaling. | `bool` | `false` | no |
| <a name="input_is_public_ip_enabled"></a> [is\_public\_ip\_enabled](#input\_is\_public\_ip\_enabled) | Especifica se o Application Gateway terá IP público. | `bool` | `true` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | SKU do Application Gateway. Aceita valores como `Standard_Small`, `Standard_Medium`, `Standard_Large`, `WAF_Medium` e `WAF_Large` para SKU v1 e `Standard_v2` e `WAF_v2` para SKU v2. | `string` | `"Standard_v2"` | no |
| <a name="input_ssl_certificate"></a> [ssl\_certificate](#input\_ssl\_certificate) | Integra um certificado SSL armazenado no Azure Key Vault ao listener do Application Gateway. | <pre>list(object({<br>    name                = string<br>    key_vault_secret_id = string<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapa de tags para os recursos. | `map(any)` | `{}` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | Define qual o tier do Application Gateway. Aceita valores como: `Standard` e `WAF` para SKU v1 e  `Standard_v2` ou `WAF_v2` para SKU v2. | `string` | `"Standard_v2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_appgw_backend_address_pools"></a> [appgw\_backend\_address\_pools](#output\_appgw\_backend\_address\_pools) | Id dos Backend Address Pools. |
| <a name="output_appgw_id"></a> [appgw\_id](#output\_appgw\_id) | Resource ID do Application Gateway |
| <a name="output_appgw_identity_client_id"></a> [appgw\_identity\_client\_id](#output\_appgw\_identity\_client\_id) | Client ID da User Assigned Identity Atribuída para o Application Gateway, quando integrado com Azure KeyVault. |
| <a name="output_appgw_identity_principal_id"></a> [appgw\_identity\_principal\_id](#output\_appgw\_identity\_principal\_id) | Principal ID da User Assigned Identity Atribuída para o Application Gateway, quando integrado com Azure KeyVault. |
| <a name="output_appgw_public_ip"></a> [appgw\_public\_ip](#output\_appgw\_public\_ip) | IP Público do Application Gateway. |

## Exemplo no Terraform 1.x

``` Go
resource "azurerm_resource_group" "rg" {
  name     = "rg-appgw"
  location = "eastus2"
}

resource "azurerm_resource_group" "vnet_rg" {
  name     = "rg-vnet"
  location = "eastus2"
}

module "vnet" {
  source = "../../modules/vnet"

  resource_group_name = azurerm_resource_group.vnet_rg.name
  location            = azurerm_resource_group.vnet_rg.location

  vnet_name     = "vnet-test"
  address_space = ["10.0.0.0/24"]
  subnet = {
    appgw_subnet = {
      address_prefix = ["10.0.0.0/27"]
    }
  }
}

module "appgw-test" {
  source = "../../modules/app-gateway"

  vnet_resource_group_name = module.vnet.rg_name
  vnet_name                = module.vnet.rg_name
  subnet_name              = module.vnet.vnet_subnet_names["appgw_subnet"]

  resource_group_name  = azurerm_resource_group.rg.name
  appgw_name           = "appgw-app1-raas-batch-dev"
  is_public_ip_enabled = true
  sku                  = "Standard_v2"
  tier                 = "Standard_v2"
  capacity             = 1

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
      target_url           = "https://www.test.com.br/"
      include_path         = false
      include_query_string = false
    }
  ]
	
  depends_on = [
    module.vnet
  ]
}

```

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

