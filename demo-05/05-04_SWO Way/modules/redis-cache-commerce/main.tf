
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
  name                          = var.name
  location                      = data.azurerm_resource_group.redis.location
  resource_group_name           = data.azurerm_resource_group.redis.name
  capacity                      = var.capacity
  family                        = lookup(local.redis_family_map, var.sku_name)
  sku_name                      = var.sku_name
  enable_non_ssl_port           = var.enable_non_ssl_port
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled
  replicas_per_master           = var.replicas_per_master

  #It only works premium Sku
  shard_count               = var.sku_name == "Premium" ? var.shard_count : 0
  private_static_ip_address = var.private_static_ip_address
  subnet_id                 = var.subnet_id
  tags                      = var.tags
  redis_configuration {
    aof_backup_enabled              = true
    aof_storage_connection_string_0 = "DefaultEndpointsProtocol=https;AccountName=commerceredisdata;AccountKey=Mz59prXKsd9QqmRimUZFc0L3OG1c/ThdVrirkfMzyLnlKpw3VtLsOHbr5JbpcAlj7myo1NjXIIEXy/nZ/yO9Bw==;EndpointSuffix=core.windows.net"

  }
}