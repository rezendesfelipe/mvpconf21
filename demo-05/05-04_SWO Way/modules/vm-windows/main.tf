data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

###String com carctéres aleatórios para tornar o recurso único
resource "random_string" "vm" {
  length  = 6
  special = false
  upper   = false
  number  = true
  lower   = true
  keepers = {
    vm_name = var.vm_name
  }
}

###Provisionamento da NIC que a VM irá fazer uso
resource "azurerm_network_interface" "vmnic" {
  name                = lower(join("-", ["nic", var.vm_name, random_string.vm.result]))
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location == null ? data.azurerm_resource_group.rg.location : var.location
  tags                = var.tags

  dynamic "ip_configuration" {
    for_each = var.nic_settings
    content {
      name                          = ip_configuration.key
      subnet_id                     = lookup(ip_configuration.value, "subnet_id")
      private_ip_address_allocation = lookup(ip_configuration.value, "private_ip_allocation", "Dynamic")
      private_ip_address            = lookup(ip_configuration.value, "private_ip_address", null)
      private_ip_address_version    = lookup(ip_configuration.value, "private_ip_address_version", "IPv4")
      primary                       = lookup(ip_configuration.value, "primary", false)
      public_ip_address_id          = lookup(ip_configuration.value, "public_ip_address_id", null)
    }
  }

  depends_on = [
    data.azurerm_resource_group.rg,
    random_id.vm
  ]
}

### Provisionamento da VM sem disco extra anexado
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location == null ? data.azurerm_resource_group.rg.location : var.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.vmnic.id]
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_pass
  zone                  = var.availability_set_id == null ? var.zone : null # If Avaliability Set is disabled, Zone is enabled
  availability_set_id   = var.zone == null ? var.availability_set_id : null # If Zone is disabled, Availability Set is enabled

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_type
    disk_size_gb         = var.os_disk_size
  }
  source_image_reference {
    publisher = var.img_publisher
    offer     = var.img_offer
    sku       = var.img_sku
    version   = "latest"
  }
  tags = var.tags

  boot_diagnostics {
    storage_account_uri = var.storage_uri
  }
  depends_on = [
    azurerm_managed_disk.datadisk
  ]
}

resource "azurerm_managed_disk" "datadisk" {
  for_each            = var.data_disks == null ? {} : var.data_disks
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location == null ? data.azurerm_resource_group.rg.location : var.location
  zones               = var.zone == null ? null : [var.zone]
  tags                = var.tags

  name                 = lookup(each.value, "name", join("-", [var.vm_name, "datadisk", each.key]))
  create_option        = lookup(each.value, "create_option", "Empty")
  disk_size_gb         = lookup(each.value, "disk_size", null)
  storage_account_type = lookup(each.value, "storage_account_type", "Standard_LRS")

  depends_on = [
    data.azurerm_resource_group.rg
  ]
}

resource "azurerm_virtual_machine_data_disk_attachment" "datadisk" {
  for_each           = var.data_disks == null ? {} : var.data_disks
  managed_disk_id    = azurerm_managed_disk.datadisk[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  lun                = lookup(each.value, "lun")
  caching            = lookup(each.value, "caching", "ReadWrite")
  create_option      = lookup(each.value, "attach_option", "Attach")
}
