output "vm_id" {
  value = azurerm_linux_virtual_machine.vm-linux.id
}

output "vm_ip" {
  value = azurerm_linux_virtual_machine.vm-linux.private_ip_address
}

output "public_ip_id" {
  description = "id of the public ip address provisoned."
  value       = azurerm_public_ip.vm.*.id
}

output "public_ip_address" {
  description = "virtual machine public ip address."
  value       = azurerm_public_ip.vm.*.ip_address
}