output "appgw_identity_client_id" {
  value       = azurerm_user_assigned_identity.identity.client_id
  description = "Client ID da User Assigned Identity Atribuída para o Application Gateway, quando integrado com Azure KeyVault."
}

output "appgw_identity_principal_id" {
  value       = azurerm_user_assigned_identity.identity.principal_id
  description = "Principal ID da User Assigned Identity Atribuída para o Application Gateway, quando integrado com Azure KeyVault."
}

output "appgw_backend_address_pools" {
  value       = azurerm_application_gateway.network.backend_address_pool.*.id
  description = "Id dos Backend Address Pools."
}

output "appgw_public_ip" {
  value       = azurerm_public_ip.appgw.*.id
  description = "IP Público do Application Gateway."
}

output "appgw_id" {
  value       = azurerm_application_gateway.network.id
  description = "Resource ID do Application Gateway"
}
