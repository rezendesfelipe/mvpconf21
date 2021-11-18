output "identity_client_id" {
  value = azurerm_user_assigned_identity.identity.client_id
}

output "identity_principal_id" {
  value = azurerm_user_assigned_identity.identity.principal_id
}

output "backend_address_pools" {
  value = azurerm_application_gateway.network.backend_address_pool.*.id
}
