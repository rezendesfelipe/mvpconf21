output "db_id" {
  value = azurerm_cosmosdb_account.db.id
}

output "db_endpoint" {
  value = azurerm_cosmosdb_account.db.endpoint
}

output "db_primary_key" {
  value     = azurerm_cosmosdb_account.db.primary_key
  sensitive = true
}

output "db_connection_strings" {
  value     = azurerm_cosmosdb_account.db.connection_strings
  sensitive = true
}
