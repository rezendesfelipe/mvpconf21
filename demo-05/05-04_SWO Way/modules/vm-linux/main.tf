data "azurerm_resource_group" "vm-linux" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  count               = var.vnet_name == null ? 0 : 1
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name == null ? var.resource_group_name : var.vnet_resource_group_name
}

data "azurerm_subnet" "subnet" {
  count                = var.vnet_name == null ? 0 : 1
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet[0].name
  resource_group_name  = data.azurerm_virtual_network.vnet[0].resource_group_name
}

###Provisionamento da NIC que a VM irá fazer uso
resource "azurerm_network_interface" "vmnic" {
  name                          = lower(join("-", [var.vm_name, "nic"]))
  location                      = var.location == null ? data.azurerm_resource_group.vm-linux.location : var.location
  resource_group_name           = data.azurerm_resource_group.vm-linux.name
  enable_accelerated_networking = var.enable_accelerated_networking

  ip_configuration {
    name                          = lower(join("-", [var.vm_name, "nic", "config"]))
    subnet_id                     = var.sn_id == null ? data.azurerm_subnet.subnet[0].id : var.sn_id
    private_ip_address_allocation = var.ip_allocation
    private_ip_address            = var.ip_allocation == "Static" ? var.ip_address : null
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = var.is_public_ip_enabled == true ? azurerm_public_ip.vm[0].id : null # esta entrada exige um valor do tipo string e estamos fazendo um teste condicional através da 'var.is_public_ip_enabled'
    primary                       = true
  }
}

### Provisionamento da VM
resource "azurerm_linux_virtual_machine" "vm-linux" {
  name                         = var.vm_name
  location                     = var.location == null ? data.azurerm_resource_group.vm-linux.location : var.location
  resource_group_name          = data.azurerm_resource_group.vm-linux.name
  network_interface_ids        = [azurerm_network_interface.vmnic.id]
  priority                     = var.priority
  eviction_policy              = var.eviction_policy
  zone                         = var.zone
  size                         = var.vm_size
  admin_username               = var.admin_lnx_username
  proximity_placement_group_id = var.proximity_placement_group_id
  availability_set_id          = var.availability_set_id

  admin_ssh_key {
    username   = var.admin_lnx_username
    public_key = var.public_key == null ? file("~/.ssh/id_rsa.pub") : var.public_key
  }

  os_disk {
    caching              = var.caching
    storage_account_type = var.stg_type
  }

  source_image_reference {
    publisher = var.img_publisher
    offer     = var.img_offer
    sku       = var.img_sku
    version   = var.img_version
  }

  dynamic "boot_diagnostics" {
    for_each = var.is_boot_diagnostics_enabled ? [var.boot_diagnostics] : []
    content {
      storage_account_uri = var.boot_stg
    }
  }
  tags = var.tags

}

resource "azurerm_managed_disk" "data-disk" {
  count                = length(var.data_disks)
  name                 = join("-", [var.vm_name, "disk-data", count.index])
  resource_group_name  = data.azurerm_resource_group.vm-linux.name
  location             = var.location == null ? data.azurerm_resource_group.vm-linux.location : var.location
  storage_account_type = lookup(var.data_disks[count.index], "storage_account_type")
  disk_size_gb         = lookup(var.data_disks[count.index], "disk_size_gb")
  zones                = var.zone == null ? null : [var.zone]
  create_option        = "Empty"
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk-attach" {
  count              = length(var.data_disks)
  managed_disk_id    = azurerm_managed_disk.data-disk[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm-linux.id
  lun                = count.index
  caching            = lookup(var.data_disks[count.index], "disk_caching")
}

resource "azurerm_public_ip" "vm" {
  count               = var.is_public_ip_enabled ? 1 : 0
  name                = lower(join("-", [var.vm_name, "pub-ip"]))
  resource_group_name = data.azurerm_resource_group.vm-linux.name
  location            = var.location == null ? data.azurerm_resource_group.vm-linux.location : var.location
  allocation_method   = var.allocation_method
  sku                 = var.public_ip_sku
  tags                = var.tags
}

resource "azurerm_virtual_machine_extension" "ext_disk" {
  count = var.is_extension_enabled ? 1 : 0

  name                 = var.ext_name
  virtual_machine_id   = azurerm_linux_virtual_machine.vm-linux.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings           = <<SETTINGS
  {
  "fileUris": ["https://${var.str_name}.blob.core.windows.net/${var.container_name}/${var.script_name}"],
  "commandToExecute":"${var.command_exec}"
  }
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
    {
      "storageAccountName":"${var.str_name}",
      "storageAccountKey":"${var.keys}"
    }
  PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_extension" "mmaagent" {
  count = var.is_log_analytics_enabled ? 1 : 0

  name                       = var.extension_log_name
  virtual_machine_id         = azurerm_linux_virtual_machine.vm-linux.id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.12"
  auto_upgrade_minor_version = "true"
  settings                   = <<SETTINGS
    {
      "workspaceId": "${var.workspaceId}"
    }
SETTINGS
  protected_settings         = <<PROTECTED_SETTINGS
   {
      "workspaceKey": "${var.workspaceKey}"
   }
PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_extension" "da" {
  count = var.is_log_analytics_enabled ? 1 : 0

  name                       = "DAExtension"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm-linux.id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentLinux"
  type_handler_version       = "9.5"
  auto_upgrade_minor_version = true

}
