output "nsg_id" {
  value       = azurerm_network_security_group.nsg.id
  description = "Resource ID do Network Security Group."
}

output "nsg_name" {
  value       = azurerm_network_security_group.nsg.name
  description = "Nome do Network Security Group."
}