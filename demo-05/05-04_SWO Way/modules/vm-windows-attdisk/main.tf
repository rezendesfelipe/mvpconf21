
###String com carctéres aleatórios para tornar o recurso único
resource "random_id" "vm" {
  byte_length = 4
}

###Provisionamento da NIC que a VM irá fazer uso
resource "azurerm_network_interface" "vmnic" {
  name                = lower(join("-", ["nic", var.vm_name, random_id.vm.hex]))
  location            = var.location #data.azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
  ip_configuration {
    name                          = lower(join("-", ["priv-ip", var.vm_name, random_id.vm.hex]))
    subnet_id                     = var.sn_id
    private_ip_address_allocation = var.ip_allocation
    private_ip_address            = var.ip_allocation == "Static" ? var.ip_address : null
    private_ip_address_version    = "IPv4"
    primary                       = true

  }
}


### Provisionamento da VM com disco extra anexado
resource "azurerm_virtual_machine" "vm-windows-disk" {

  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vmnic.id]
  vm_size               = var.vm_size
  tags                  = var.tags
  storage_image_reference {
    publisher = var.img_publisher
    offer     = var.img_offer
    sku       = var.img_sku
    version   = "latest"
  }

  storage_os_disk {
    name              = join("-", ["disk", var.vm_name, random_id.vm.hex])
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.stg_type
  }

  storage_data_disk {
    name              = join("-", ["data-disk", var.vm_name, random_id.vm.hex])
    managed_disk_type = var.stg_type
    disk_size_gb      = var.disk_size_gb
    create_option     = "Empty"
    lun               = var.lun
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_win_username
    admin_password = var.admin_win_pass
  }
  os_profile_windows_config {

  }

  boot_diagnostics {
    storage_uri = var.storage_uri
    enabled     = true
  }

}