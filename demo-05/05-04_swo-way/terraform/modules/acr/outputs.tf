output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "Azure Container Registry Login Server Name."
}

output "acr_admin_username" {
  value       = azurerm_container_registry.acr.admin_username
  description = "Nome do usuário administrador do Container Registry"
}

output "acr_admin_password" {
  sensitive   = true
  value       = azurerm_container_registry.acr.admin_password
  description = "Senha do usuário administrador o Azure Container Registry."
}

output "acr_id" {
  sensitive   = true
  value       = azurerm_container_registry.acr.id
  description = "Resource ID do Azure Container Registry"
}
