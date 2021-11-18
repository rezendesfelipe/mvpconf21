output "server_id" {
  value = azurerm_mysql_server.server.id
}

output "server_fqdn" {
  value = azurerm_mysql_server.server.fqdn
}
