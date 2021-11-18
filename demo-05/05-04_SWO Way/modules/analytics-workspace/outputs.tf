output "analytics_resource_id" {
  value = azurerm_log_analytics_workspace.analytics_works.id
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.analytics_works.workspace_id
}

output "primary_shared_key" {
  value = azurerm_log_analytics_workspace.analytics_works.primary_shared_key
}