# Módulo de Azure VM-Windows
## Variáveis válidas (Globais)
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado. O padrão é fazer uso do resource group de sua vertical (Ex: Impulse)
* [Obrigatório] `location`: Localidade onde a VM será criada. O valor padrão é `eastus2`.
* [Opcional] `tags`: Quais tags serão utilizados. Normalmente ele já irá puxar no momento em que o módulo for chamado.

## Variáveis válidas (NIC)
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado. O padrão é fazer uso do resource group de sua vertical (Ex: Impulse)

Um exemplo de como pode ser realizado:
``` Go
  resource_group_name = module.rg.rg_name
```

* [Obrigatório] `ip_allocation`: Parâmetro que define se um IP será estático ou dinâmico. O valor padrão é O valor padrão é `dinâmico`.
* [Obrigatório] `ip_address`: Endereço IP da VM 

## Variáveis válidas (VM)

* [Obrigatório] `vm_name`: Nome da VM.
* [Obrigatório] `vm-size`: Size da VM. "Standard B2ms"
* [Obrigatório] `admin_win_username`: Usuário de acesso para a vm.
* [Obrigatório] `admin_win_pass`: Senha de acesso para a vm. OBS.: utilizar arquivo tfvars 
* [Obrigatório] `caching`: Cache do disco. (Ex: ReadWrite) 
* [Obrigatório] `stg_type`: Tipo de armazenamento da storage account do disco. *Ex: Standard_LRS) 
* [Obrigatório] `img_publisher`: Publisher da Imagem: (Ex: MicrosoftWindowsServer)
* [Obrigatório] `img_offer`: Offer da Imagem. (Ex: WindowsServer) 
* [Obrigatório] `img_sku`: SKU da imagem. (Ex: 2012-Datacenter)  
* [Obrigatório] `img_version`: Versão da imagem.O valor padrão é O valor padrão é `latest`. 


OBS.: Para listar as informações da vm é só utilizar o comando:

az vm image list

## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
resource "random_id" "vm" {
  byte_length = 8
}

###Provisionamento da NIC que a VM irá fazer uso
resource "azurerm_network_interface" "vmnic" {
  name                = lower(join("-", [var.vm_name, random_id.vm.hex, "nic"]))
  location            = var.location #data.azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = lower(join("-", [var.vm_name, random_id.vm.hex, "nic", "config"]))
    subnet_id                     = "sn-teste"
    private_ip_address_allocation = var.ip_allocation
    private_ip_address = var.ip_allocation == "Static" ? var.ip_address : null
    private_ip_address_version    = "IPv4"
    primary                       = true
  }
}

### Provisionamento da VM
resource "azurerm_windows_virtual_machine" "vm-windows" {

  name                  = join("-", [var.vm_name, random_id.vm.hex])
  location              = var.location 
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vmnic.id]
  size               = var.vm_size
  admin_username = var.admin_win_username
  admin_password = var.admin_win_pass
 os_disk {
    caching              = var.caching
    storage_account_type = var.stg_type
  }
source_image_reference {
    publisher = var.img_publisher
    offer     = var.img_offer
    sku       = var.img_sku
    version   = "latest"
  }


}
```

``` Go
Terraform will perform the following actions:

  # module.rg.azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus2"
      + name     = "rg-impulse-datacollection-dev"
    }

  # module.vm-windows.azurerm_network_interface.vmnic will be created
  + resource "azurerm_network_interface" "vmnic" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "eastus2"
      + mac_address                   = (known after apply)
      + name                          = (known after apply)
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "rg-impulse-datacollection-dev"
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + name                          = (known after apply)
          + primary                       = true
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = "static"
          + private_ip_address_version    = "IPv4"
          + subnet_id                     = "sn-teste"
        }
    }

  # module.vm-windows.azurerm_windows_virtual_machine.vm-windows will be created
  + resource "azurerm_windows_virtual_machine" "vm-windows" {
      + admin_password             = (sensitive value)
      + admin_username             = "azuretfuser"
      + allow_extension_operations = true
      + computer_name              = (known after apply)
      + enable_automatic_updates   = true
      + extensions_time_budget     = "PT1H30M"
      + id                         = (known after apply)
      + location                   = "eastus2"
      + max_bid_price              = -1
      + name                       = (known after apply)
      + network_interface_ids      = (known after apply)
      + patch_mode                 = "AutomaticByOS"
      + platform_fault_domain      = -1
      + priority                   = "Regular"
      + private_ip_address         = (known after apply)
      + private_ip_addresses       = (known after apply)
      + provision_vm_agent         = true
      + public_ip_address          = (known after apply)
      + public_ip_addresses        = (known after apply)
      + resource_group_name        = "rg-impulse-datacollection-dev"
      + size                       = "Standard B2ms"
      + virtual_machine_id         = (known after apply)
      + zone                       = (known after apply)

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "WindowsServer"
          + publisher = "MicrosoftWindowsServer"
          + sku       = "2019-Datacenter"
          + version   = "latest"
        }
    }

  # module.vm-windows.random_id.vm will be created
  + resource "random_id" "vm" {
      + b64_std     = (known after apply)
      + b64_url     = (known after apply)
      + byte_length = 8
      + dec         = (known after apply)
      + hex         = (known after apply)
      + id          = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.
```
