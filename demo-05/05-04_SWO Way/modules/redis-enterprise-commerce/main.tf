
data "azurerm_resource_group" "redis-enterprise" {
  name = var.resource_group_name
}

resource "azurerm_redis_enterprise_cluster" "redis-enterprise" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.redis-enterprise.name
  location            = data.azurerm_resource_group.redis-enterprise.location
  sku_name            = var.sku_name
}

resource "azurerm_redis_enterprise_database" "redis-enterprise" {
  resource_group_name = data.azurerm_resource_group.redis-enterprise.name
  clustering_policy   = "EnterpriseCluster"
  cluster_id          = azurerm_redis_enterprise_cluster.redis-enterprise.id
  eviction_policy     = "NoEviction"
  client_protocol     = "Plaintext"
}


resource "azurerm_private_endpoint" "endpoint" {
  # count               = var.is_endpoint_enabled ? 1 : 0
  name                = join("-", ["pe", azurerm_redis_enterprise_cluster.redis-enterprise.name])
  resource_group_name = data.azurerm_resource_group.redis-enterprise.name
  location            = data.azurerm_resource_group.redis-enterprise.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = join("-", ["psc", azurerm_redis_enterprise_cluster.redis-enterprise.name])
    is_manual_connection           = false
    private_connection_resource_id = azurerm_redis_enterprise_cluster.redis-enterprise.id
    subresource_names              = ["redisEnterprise"]
  }
  tags = var.tags
}