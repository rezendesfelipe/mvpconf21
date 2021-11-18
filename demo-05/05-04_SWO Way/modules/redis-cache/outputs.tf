output "redis_id" {
  value       = azurerm_redis_cache.redis.id
  description = "Redis instance id"
}

output "redis_name" {
  value       = azurerm_redis_cache.redis.name
  description = "Redis instance name"
}

output "redis_hostname" {
  value       = azurerm_redis_cache.redis.hostname
  description = "Redis instance hostname"
}

output "redis_ssl_port" {
  value       = azurerm_redis_cache.redis.ssl_port
  description = "Redis instance SSL port"
}

output "redis_port" {
  value       = azurerm_redis_cache.redis.port
  description = "Redis instance port"
}

output "redis_primary_access_key" {
  sensitive   = true
  value       = azurerm_redis_cache.redis.primary_access_key
  description = "Redis primary access key"
}

output "redis_secondary_access_key" {
  sensitive   = true
  value       = azurerm_redis_cache.redis.secondary_access_key
  description = "Redis secondary access key"
}

output "redis_private_static_ip_address" {
  value       = azurerm_redis_cache.redis.private_static_ip_address
  description = "Redis private static IP address"
}

output "redis_sku_name" {
  value       = azurerm_redis_cache.redis.sku_name
  description = "Redis SKU name"
}

output "redis_family" {
  value       = azurerm_redis_cache.redis.family
  description = "Redis family"
}

output "redis_capacity" {
  value       = azurerm_redis_cache.redis.capacity
  description = "Redis capacity"
}

output "redis_configuration" {
  sensitive   = true
  value       = azurerm_redis_cache.redis.redis_configuration
  description = "Redis configuration"
}
