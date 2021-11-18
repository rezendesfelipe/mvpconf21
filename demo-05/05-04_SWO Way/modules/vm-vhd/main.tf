resource "random_id" "vm" {
  byte_length = 4
}

###Provisionamento da NIC que a VM irá fazer uso
resource "azurerm_network_interface" "vmnic" {
  name                = lower(join("-", ["nic", var.vm_name, random_id.vm.hex]))
  location            = var.location #data.azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = lower(join("-", ["priv-ip", var.vm_name, random_id.vm.hex]))
    subnet_id                     = var.sn_id
    private_ip_address_allocation = var.ip_allocation
    private_ip_address            = var.ip_allocation == "Static" ? var.ip_address : null
    private_ip_address_version    = "IPv4"
    primary                       = true
  }
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "appgw_association" {
  count                   = var.appgw_backend_address_pool_id != null ? 1 : 0
  backend_address_pool_id = var.appgw_backend_address_pool_id
  ip_configuration_name   = lower(join("-", ["priv-ip", var.vm_name, random_id.vm.hex]))
  network_interface_id    = azurerm_network_interface.vmnic.id
}

# ### Block responsible for the VM
resource "azurerm_virtual_machine" "vm-vhd-linux" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vmnic.id]
  vm_size               = var.vm_size
  tags                  = var.tags

  storage_image_reference {
    id = var.image_id
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = "azureuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = var.path_pubkey #"~/.ssh/cloud_digital.pub"
    }
  }

  storage_os_disk {
    name              = join("-", ["disk", var.vm_name, random_id.vm.hex])
    create_option     = "FromImage"
    managed_disk_type = var.stg_type
  }

  storage_data_disk {
    name              = join("-", ["data-disk", var.vm_name, random_id.vm.hex])
    managed_disk_type = var.stg_type
    disk_size_gb      = var.disk_size_gb
    create_option     = "FromImage"
    lun               = var.lun
  }

  boot_diagnostics {
    storage_uri = var.storage_uri
    enabled     = true
  }
}