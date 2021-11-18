output "frontdoor_routing_rule" {
  value = azurerm_frontdoor.instance.routing_rule
}

output "backend_pool_health_probe" {
  value = azurerm_frontdoor.instance.backend_pool_health_probe
}

output "backend_pool_load_balancing" {
  value = azurerm_frontdoor.instance.backend_pool_load_balancing
}

output "backend_pool" {
  value = azurerm_frontdoor.instance.backend_pool
}

output "frontend_endpoint" {
  value = azurerm_frontdoor.instance.frontend_endpoint
}