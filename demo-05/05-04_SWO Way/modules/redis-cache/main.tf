
data "azurerm_resource_group" "redis" {
  name = var.resource_group_name
}

locals {
  redis_family_map = {
    Basic    = "C",
    Standard = "C",
    Premium  = "P"
  }
}

resource "random_string" "redis_name" {
  length  = 4
  special = false
  number  = false
}

resource "azurerm_redis_cache" "redis" {
  name                = lower(join("-", [var.name, random_string.redis_name.result]))
  location            = data.azurerm_resource_group.redis.location
  resource_group_name = data.azurerm_resource_group.redis.name
  capacity            = var.capacity
  family              = lookup(local.redis_family_map, var.sku_name)
  sku_name            = var.sku_name
  enable_non_ssl_port = var.enable_non_ssl_port
  minimum_tls_version = var.minimum_tls_version

  #It only works premium Sku
  shard_count                   = var.sku_name == "Premium" ? var.shard_count : 0
  private_static_ip_address     = var.private_static_ip_address
  public_network_access_enabled = var.is_public_network_access_enabled
  subnet_id                     = var.is_endpoint_enabled ? null : var.subnet_id
  tags                          = var.tags
  redis_configuration {
    enable_authentication = var.sku_name == "Premium" && var.subnet_id == null ? true : var.enable_authentication
  }
}

resource "azurerm_redis_firewall_rule" "fwrules" {
  for_each            = { for rule in var.firewall_rules : rule.name => rule }
  name                = each.value.name
  redis_cache_name    = azurerm_redis_cache.redis.name
  resource_group_name = data.azurerm_resource_group.redis.name
  start_ip            = each.value.start_ip
  end_ip              = each.value.end_ip
}

resource "azurerm_private_endpoint" "endpoint" {
  count               = var.is_endpoint_enabled ? 1 : 0
  name                = join("-", ["pvt", azurerm_redis_cache.redis.name])
  resource_group_name = data.azurerm_resource_group.redis.name
  location            = data.azurerm_resource_group.redis.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = join("-", ["psc", azurerm_redis_cache.redis.name])
    is_manual_connection           = false
    private_connection_resource_id = azurerm_redis_cache.redis.id
    subresource_names              = ["redisCache"]
  }
  tags = var.tags
}
