data "azurerm_resource_group" "appgw" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "appgw" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "appgw" {
  name                 = var.subnet_name
  resource_group_name  = var.vnet_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.appgw.name
}

locals {
  location = var.location != null ? var.location : data.azurerm_resource_group.appgw.location
}

resource "azurerm_public_ip" "appgw" {
  count               = var.is_public_ip_enabled ? 1 : 0
  name                = join("-", ["pip", var.appgw_name])
  resource_group_name = data.azurerm_resource_group.appgw.name
  location            = local.location
  allocation_method   = var.ip_sku
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_user_assigned_identity" "identity" {
  name                = join("-", ["identity", var.appgw_name])
  resource_group_name = data.azurerm_resource_group.appgw.name
  location            = local.location
  tags                = var.tags
}

resource "azurerm_application_gateway" "network" {
  name                = var.appgw_name
  resource_group_name = data.azurerm_resource_group.appgw.name
  location            = local.location

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.identity.id]
  }

  sku {
    name     = var.sku
    tier     = var.tier
    capacity = var.capacity
  }

  dynamic "autoscale_configuration" {
    for_each = var.is_autoscale_enabled ? [1] : []
    content {
      max_capacity = var.autoscale_max_capacity
      min_capacity = var.autoscale_min_capacity
    }
  }

  gateway_ip_configuration {
    name      = "appGwIpConfiguration"
    subnet_id = data.azurerm_subnet.appgw.id
  }

  dynamic "frontend_port" {
    for_each = var.frontend_ports
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = toset(var.frontends)
    content {
      name                          = frontend_ip_configuration.value.name
      public_ip_address_id          = frontend_ip_configuration.value.is_public_ip_enabled ? azurerm_public_ip.appgw[0].id : null
      private_ip_address            = frontend_ip_configuration.value.is_public_ip_enabled ? null : frontend_ip_configuration.value.private_ip_address
      private_ip_address_allocation = frontend_ip_configuration.value.is_public_ip_enabled ? null : "Static"
      subnet_id                     = frontend_ip_configuration.value.is_public_ip_enabled ? null : data.azurerm_subnet.appgw.id
    }
  }

  dynamic "backend_address_pool" {
    for_each = toset(var.backend_address_pool)
    content {
      name = backend_address_pool.value
    }
  }

  dynamic "backend_http_settings" {
    for_each = toset(var.backend_http_settings)
    content {
      name                                = backend_http_settings.value.name
      cookie_based_affinity               = backend_http_settings.value.cookie_based_affinity
      affinity_cookie_name                = backend_http_settings.value.affinity_cookie_name
      path                                = backend_http_settings.value.path
      port                                = backend_http_settings.value.port
      probe_name                          = backend_http_settings.value.probe_name
      protocol                            = backend_http_settings.value.protocol
      request_timeout                     = backend_http_settings.value.request_timeout
      host_name                           = backend_http_settings.value.host_name
      pick_host_name_from_backend_address = backend_http_settings.value.pick_host_name_from_backend_address
    }
  }

  dynamic "probe" {
    for_each = var.probes
    content {
      interval                                  = probe.value.interval
      name                                      = probe.value.name
      path                                      = probe.value.path
      protocol                                  = probe.value.protocol
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
    }
  }


  dynamic "http_listener" {
    for_each = var.http_listener
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      ssl_certificate_name           = http_listener.value.ssl_certificate_name
      host_name                      = http_listener.value.host_name
      require_sni                    = http_listener.value.ssl_certificate_name != null ? http_listener.value.require_sni : null
    }
  }

  dynamic "ssl_certificate" {
    for_each = toset(var.ssl_certificate)
    content {
      name                = ssl_certificate.value.name
      key_vault_secret_id = ssl_certificate.value.key_vault_secret_id
    }
  }

  dynamic "request_routing_rule" {
    for_each = toset(var.rules)
    content {
      name                        = request_routing_rule.value.name
      rule_type                   = request_routing_rule.value.rule_type
      http_listener_name          = request_routing_rule.value.http_listener_name
      backend_address_pool_name   = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name  = request_routing_rule.value.backend_http_settings_name
      redirect_configuration_name = request_routing_rule.value.redirect_configuration_name
      url_path_map_name           = request_routing_rule.value.url_path_map_name
    }
  }

  dynamic "url_path_map" {
    for_each = toset(var.url_path_map)
    content {
      name                                = url_path_map.value.name
      default_backend_address_pool_name   = url_path_map.value.default_backend_address_pool_name
      default_backend_http_settings_name  = url_path_map.value.default_backend_http_settings_name
      default_redirect_configuration_name = url_path_map.value.default_redirect_configuration_name

      dynamic "path_rule" {
        for_each = toset(url_path_map.value.path_rules)
        content {
          name                        = path_rule.value.name
          paths                       = path_rule.value.paths
          backend_address_pool_name   = path_rule.value.backend_address_pool_name
          backend_http_settings_name  = path_rule.value.backend_http_settings_name
          redirect_configuration_name = path_rule.value.redirect_configuration_name
        }
      }
    }
  }

  dynamic "redirect_configuration" {
    for_each = toset(var.redirect_configurations)
    content {
      name                 = redirect_configuration.value.name
      redirect_type        = redirect_configuration.value.redirect_type
      target_listener_name = redirect_configuration.value.target_listener_name
      target_url           = redirect_configuration.value.target_url
      include_path         = redirect_configuration.value.include_path
      include_query_string = redirect_configuration.value.include_query_string
    }
  }

}
