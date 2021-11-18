data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.vnet_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

locals {
  association_be_addresses = flatten([
    for backend_index, backend in var.backends : [
      for ip_address in backend.ip_addresses : {
        name       = backend.name
        ip_address = ip_address
        pool_index = backend_index
      }
    ]
  ])
  backend_pools = {
    for backend in azurerm_lb_backend_address_pool.be_pools :
    backend.name => backend.id
  }
  probes = {
    for probe in azurerm_lb_probe.probes :
    probe.name => probe.id
  }
}

resource "azurerm_public_ip" "lb-pip" {
  for_each = {
    for frontend in var.frontends :
    frontend.name => frontend
    if var.is_public_ip_enabled
  }
  name                = join("-", [var.name, each.key, "ip"])
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location != null ? var.location : data.azurerm_resource_group.rg.location
  allocation_method   = "Static"
  ip_version          = "IPv4"
  sku                 = var.sku
  tags                = var.tags
}

resource "azurerm_lb" "lb" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location != null ? var.location : data.azurerm_resource_group.rg.location
  sku                 = var.sku

  dynamic "frontend_ip_configuration" {
    for_each = toset(var.frontends)
    content {
      name                          = frontend_ip_configuration.value["name"]
      subnet_id                     = var.is_public_ip_enabled ? null : data.azurerm_subnet.subnet.id
      private_ip_address_allocation = var.is_public_ip_enabled ? null : frontend_ip_configuration.value["private_ip_address_allocation"]
      private_ip_address            = var.is_public_ip_enabled ? null : frontend_ip_configuration.value["private_ip_address"]
      private_ip_address_version    = "IPv4"
      public_ip_address_id          = var.is_public_ip_enabled ? azurerm_public_ip.lb-pip[frontend_ip_configuration.value["name"]].id : null
    }
  }

  tags = var.tags

}

resource "azurerm_lb_backend_address_pool" "be_pools" {
  count           = length(var.backends)
  loadbalancer_id = azurerm_lb.lb.id
  name            = var.backends[count.index].name
}

resource "azurerm_lb_backend_address_pool_address" "be_pool_addresses" {
  count                   = length(local.association_be_addresses)
  name                    = "${local.association_be_addresses[count.index].name}${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.be_pools[local.association_be_addresses[count.index].pool_index].id
  ip_address              = local.association_be_addresses[count.index].ip_address
  virtual_network_id      = data.azurerm_virtual_network.vnet.id
}

resource "azurerm_lb_probe" "probes" {
  count               = length(var.probes)
  resource_group_name = data.azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = var.probes[count.index].name
  protocol            = var.probes[count.index].protocol
  port                = var.probes[count.index].port
  request_path        = var.probes[count.index].request_path
  interval_in_seconds = var.probes[count.index].interval_in_seconds
  number_of_probes    = var.probes[count.index].number_of_probes
}

resource "azurerm_lb_rule" "rules" {
  count                          = length(var.rules)
  resource_group_name            = data.azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = var.rules[count.index].name
  frontend_ip_configuration_name = var.rules[count.index].frontend_name
  backend_address_pool_id        = local.backend_pools[var.rules[count.index].backend_pool_name]
  probe_id                       = local.probes[var.rules[count.index].probe_name]
  protocol                       = var.rules[count.index].protocol
  frontend_port                  = var.rules[count.index].frontend_port
  backend_port                   = var.rules[count.index].backend_port
  enable_floating_ip             = var.rules[count.index].enable_floating_ip
  idle_timeout_in_minutes        = var.rules[count.index].idle_timeout_in_minutes
  load_distribution              = var.rules[count.index].load_distribution
  disable_outbound_snat          = var.rules[count.index].disable_outbound_snat
  enable_tcp_reset               = var.rules[count.index].enable_tcp_reset
}
