output "lb_id" {
  value = azurerm_lb.lb.id
}

output "lb_be_address_pools_ids" {
  value = azurerm_lb_backend_address_pool.be_pools.*.id
}
