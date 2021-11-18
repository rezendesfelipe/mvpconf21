output "vm_id" {
  value       = azurerm_windows_virtual_machine.vm.id
  description = "Resource ID of the virtual Machine"
}

output "vm_ip" {
  value       = azurerm_windows_virtual_machine.vm.private_ip_address
  description = "Private IP of the Virtual Machine"
}
