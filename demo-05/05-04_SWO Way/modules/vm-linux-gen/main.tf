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
    managed_disk_type = var.stg_type
    name              = join("-", ["disk", var.vm_name, random_id.vm.hex])
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  boot_diagnostics {
    storage_uri = var.storage_uri
    enabled     = true
  }
}