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
