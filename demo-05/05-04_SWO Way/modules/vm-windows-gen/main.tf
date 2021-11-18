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
    public_ip_address_id          = var.existing_public_ip == true ? var.public_ip_id : var.is_public_ip_enabled ? azurerm_public_ip.vm[0].id : null
  }
}

# ### Block responsible for the VM
resource "azurerm_virtual_machine" "vm-vhd-windows" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vmnic.id]
  vm_size               = var.vm_size
  tags                  = var.tags

  storage_image_reference {
    id = var.image_id
  }

  storage_os_disk {
    name              = join("-", ["disk", var.vm_name, random_id.vm.hex])
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_win_username
    admin_password = var.admin_win_pass
  }

  os_profile_windows_config {
    enable_automatic_upgrades = "true"
    provision_vm_agent        = "true"
  }

  boot_diagnostics {
    storage_uri = var.storage_uri
    enabled     = true
  }
}

resource "azurerm_public_ip" "vm" {
  count               = var.is_public_ip_enabled ? 1 : 0
  name                = lower(join("-", [var.vm_name, "pub-ip"]))
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = var.public_ip_sku
  tags                = var.tags
}
