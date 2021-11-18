output "aci-group_id" {
  value       = azurerm_container_group.aci.id
  description = "Azure container instance group ID"
}

output "aci-group_ip_address" {
  value       = azurerm_container_group.aci.ip_address
  description = "The IP address allocated to the container instance group."
}

output "aci-group_fqdn" {
  value       = azurerm_container_group.aci.fqdn
  description = "The FQDN of the container group derived from `dns_name_label`."
}