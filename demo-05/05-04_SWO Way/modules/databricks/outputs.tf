output "databricks_id" {
  description = "The ID of the Databricks Workspace in the Azure management plane."
  value       = azurerm_databricks_workspace.dbks.id
}

output "databricks_managed_resource_group_id" {
  description = "The ID of the Managed Resource Group created by the Databricks Workspace."
  value       = azurerm_databricks_workspace.dbks.managed_resource_group_id
}

output "databricks_workspace_url" {
  description = "The workspace URL which is of the format 'adb-{workspaceId}.{random}.azuredatabricks.net"
  value       = azurerm_databricks_workspace.dbks.workspace_url
}

output "databricks_workspace_id" {
  description = "The ID of the Managed Resource Group created by the Databricks Workspace."
  value       = azurerm_databricks_workspace.dbks.workspace_id
}

output "random" {
  value = random_string.random
}