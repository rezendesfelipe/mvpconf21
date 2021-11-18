data "azurerm_resource_group" "vmssw" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vmssw" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.vmssw.name
}

data "azurerm_subnet" "vmssw" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.vmssw.name
  virtual_network_name = data.azurerm_virtual_network.vmssw.name
}

resource "azurerm_windows_virtual_machine_scale_set" "vmssw" {
  name                = var.vmssw_name
  location            = data.azurerm_resource_group.vmssw.location
  resource_group_name = data.azurerm_resource_group.vmssw.name
  admin_password      = var.admin_password
  admin_username      = var.admin_username
  instances           = var.instances
  sku                 = var.sku

  network_interface {
    name = var.network_interface_name

    ip_configuration {
      name                                         = var.network_interface_ip_config_name
      application_gateway_backend_address_pool_ids = var.network_interface_ip_application_gateway_backend_ids
      load_balancer_backend_address_pool_ids       = var.network_interface_ip_load_balancer_backend_ids
      load_balancer_inbound_nat_rules_ids          = var.network_interface_ip_load_balancer_inbound_nat_rules_ids
      primary                                      = var.network_interface_ip_config_primary
      subnet_id                                    = data.azurerm_subnet.vmssw.id
    }

    enable_accelerated_networking = var.network_interface_enable_accelerated_networking
    primary                       = var.network_interface_primary

  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  additional_capabilities {
    ultra_ssd_enabled = var.additional_capabilities_ultra_ssd_enabled
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  dynamic "data_disk" {
    for_each = toset(var.data_disks)

    content {
      caching              = data_disk.value["caching"]
      create_option        = data_disk.value["create_option"]
      disk_size_gb         = data_disk.value["disk_size_gb"]
      lun                  = data_disk.value["lun"]
      storage_account_type = data_disk.value["storage_account_type"]
    }

  }

  encryption_at_host_enabled  = var.encryption_at_host_enabled
  platform_fault_domain_count = var.platform_fault_domain_count
  priority                    = var.priority
  provision_vm_agent          = var.provision_vm_agent
  scale_in_policy             = var.scale_in_policy

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  tags = var.tags

  zone_balance = var.zone_balance
  zones        = var.zones

}
#Feature ainda não está funcionando de maneira adequada, optamos por deixar em hold
# resource "azurerm_virtual_machine_scale_set_extension" "ext" {
#   count = var.is_extension_enabled ? 1 : 0

#   name                         = var.ext_name
#   virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.vmssw.id
#   publisher                    = "Microsoft.Compute"
#   type                         = "CustomScriptExtension"
#   type_handler_version         = "1.10"

#   settings           = <<SETTINGS
#   {
#   "fileUris": ["https://${var.str_name}.blob.core.windows.net/${var.container_name}/${var.script_name}"],
#   "commandToExecute": "${var.command_exec}"
#   }
# SETTINGS
#   protected_settings = <<PROTECTED_SETTINGS
#     {
#       "storageAccountName":"${var.str_name}",
#       "storageAccountKey":"${var.keys}"
#     }
#   PROTECTED_SETTINGS
# }
