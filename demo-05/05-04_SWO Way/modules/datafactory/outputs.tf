output "datafactory_id" {
  description = "The ID of the Datafactory instance."
  value       = azurerm_data_factory.df.id
}

output "datafactory_name" {
  description = "The name of the Datafactory instance."
  value       = azurerm_data_factory.df.name
}