resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "windows_vm" {
  source              = "./modules/vm-windows"
  admin_pass          = "teste1"
  admin_username      = "teste1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vm_name             = var.vm_name

  img_publisher = "MicrosoftWindowsServer"
  img_offer     = "WindowsServer"
  img_sku       = "2019-Datacenter"

  os_disk_caching      = "ReadWrite"
  os_disk_storage_type = "StandardSSD_LRS"
  os_disk_size         = 127

  vm_size = "Standard_B2s"
  zone    = "1"

  nic_settings = {
    ipconfig1 = {
      subnet_id = module.vnet.vnet_subnet_ids[var.mgmt_subnet_name]
      primary   = true
    }
    ipconfig2 = {
      subnet_id = module.vnet.vnet_subnet_ids[var.mgmt_subnet_name]
    }
  }

  data_disks = {
    datadisk1 = {
      disk_size            = 30
      storage_account_type = "StandardSSD_LRS"
      lun                  = 0
    }
    datadisk2 = {
      disk_size     = 34
      lun           = 1
      create_option = "Empty"
      attach_option = "Attach"
    }
    datadisk3 = {
      disk_size     = 100
      lun           = 2
      create_option = "Empty"
      attach_option = "Empty"
    }
  }
  depends_on = [
    module.vnet
  ]
}
