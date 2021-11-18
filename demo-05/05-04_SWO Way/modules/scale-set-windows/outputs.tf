output "scale_set_windows_id" {
  value = azurerm_windows_virtual_machine_scale_set.vmssw.id
}

output "scale_set_windows_identity" {
  value = azurerm_windows_virtual_machine_scale_set.vmssw.identity
}

output "scale_set_windows_unique_id" {
  value = azurerm_windows_virtual_machine_scale_set.vmssw.unique_id
}
