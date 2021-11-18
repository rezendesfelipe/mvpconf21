output "scale_set_linux_id" {
  value = azurerm_linux_virtual_machine_scale_set.vmssl.id
}

output "scale_set_linux_identity" {
  value = azurerm_linux_virtual_machine_scale_set.vmssl.identity
}

output "scale_set_linux_unique_id" {
  value = azurerm_linux_virtual_machine_scale_set.vmssl.unique_id
}
