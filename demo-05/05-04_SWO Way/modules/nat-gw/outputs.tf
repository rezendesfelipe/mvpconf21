output "ngw_id" {
  description = "The address space of the newly created vNet"
  value       = azurerm_nat_gateway.nat-gateway.id
}

output "ngw_resource_guid" {
  description = "The address space of the newly created vNet"
  value       = azurerm_nat_gateway.nat-gateway.resource_guid
}

