# Módulo de Azure VM-Linux
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
* [Obrigatório] `sn_id`: ID da subnet. Não deve ser usado em conjunto com os 3 parâmetros apresentados adiante. 

Um exemplo de como pode ser realizado:
``` Go
  resource_group_name = module.vnet.vnet_subnet_ids
```

Caso `sn_id` esteja vazio, você deve utilizar os seguintes valores **obrigatoriamente**:
* [Obrigatório] `vnet_resource_group_name`: Nome do Resource Group em que se encontra a Virtual Network.
* [Obrigatório] `vnet_name`: Nome da rede virtual em que a máquina virtual será vinculada
* [Obrigatório] `subnet_name`: Nome da sub-rede presente na rede virtual

Exemplo de uso com estes blocos: 
``` HCL
  vnet_resource_group_name = data.terraform_remote_state.shared.outputs.shared_rg_name
  vnet_name                = data.terraform_remote_state.shared.outputs.vnet_name
  subnet_name              = "subnet-mail-mgmt"
```

## Variáveis válidas (VM)

* [Obrigatório] `resource`: Compõe o nome da VM e recursos associados de acordo com o documento de nomenclatura.
* [Obrigatório] `vm_name`: Nome da VM.
* [Obrigatório] `vm-size`: Size da VM. "Standard B2ms"
* [Obrigatório] `admin_lnx_username`: Usuário de acesso para a vm.
* [Obrigatório] `caching`: Cache do disco. (Ex: ReadWrite) 
* [Obrigatório] `stg_type`: Tipo de armazenamento da storage account do disco. *Ex: Standard_LRS) 
* [Obrigatório] `img_publisher`: Publisher da Imagem: (Ex: Canonical)
* [Obrigatório] `img_offer`: Offer da Imagem. (Ex: UbuntuServer) 
* [Obrigatório] `img_sku`: SKU da imagem. (Ex: 18.04-LTS)  
* [Obrigatório] `img_version`: Versão da imagem.O valor padrão é O valor padrão é `latest`.
* [Opcional] `zone`: Zona de disponibilidade a ser utilizada. Aceita 1, 2 ou 3. O padrão é `null` (não utiliza zonas).
* [Opcional] `data_disks`: Lista de discos de dados a serem criados e utilizados pela VM.
* [Opcional] `public_key`: Chave pública a ser utilizada pela VM.
* [Opcional] `is_boot_diagnostics_enabled`: inserindo o valor true esta função será habilitada e os logs e históricos irão para uma storage acoount gerenciada pela MS. O valor padrão está definido como false.

## Variáveis válidas (Extensions)

* [Obrigatório] `keys` : "Access Key da storage account responsavel por armazenar o Script"
* [Obrigatório] `ext_name` : "Nome da extensão"
* [Obrigatório] `script_name` : "Nome do Script que será executado"
* [Obrigatório] `container_name` : "Nome do container da storage account"
* [Obrigatório] `command_exec` : "Commando de execução"
* [Obrigatório] `str_name` : "Nome da storage account"
* [Obrigatório] `is_extension_enabled` : "Boollean que verifica se o bloco de extension será executado"
## OBS: Depois de habilitada a extensão, importante destacar a necessidade deletar a extensão manualmente, toda vez que um novo disco for adicionado, assim ele será attachado na vm com sucesso.
## Ouputs gerados pelo módulo
* `vm_id`: id da VM
* `vm_ip`: endereço de ip privado da VM


OBS.: Para listar as informações da vm é só utilizar o comando:

az vm image list





## Casos de uso

### Exemplo de utilização da Feature Extensions
Terraform 0.14.x
``` Go
module "vm" {
 .......
 .......
  is_extension_enabled = true
  ext_name             = "extensionteste"
  command_exec         = "./prepare_vm_disks.sh"
  script_name          = "prepare_vm_disks.sh"
  container_name       = "new"
  str_name             = "dp200sd"
  keys                 = var.keys

}
```
### Exemplo de utilização do modulo completo com Extensão
Terraform 0.14.x
``` Go
module "vm" {
  #count               = 1 # Qtde de VMs no cluster
  source              = "../terraform-cloud/modules/vm-linux"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "eastus"
  public_key          = "ssh-rsa"
  tags = {
    role        = "mvpconf21-cluster"
    team        = "search"
    suite       = "impulse"
    product     = "search"
    env         = "dev"
    provisioner = "terraform"
  }
  sn_id                = module.vnet.vnet_subnet_ids[1]
  is_public_ip_enabled = true
  vm_name              = "newvm" # nome da VM no formato desejado
  vm_size              = "Standard_D2s_v3"
  img_publisher        = "Canonical"
  img_offer            = "UbuntuServer"
  img_sku              = "14.04.5-LTS"
  data_disks = [
    {
      storage_account_type = "Premium_LRS"
      disk_size_gb         = "512"
      disk_caching         = "ReadOnly"
    }
  ]
  is_extension_enabled = true
  ext_name             = "extensionteste"
  command_exec         = "./prepare_vm_disks.sh"
  script_name          = "prepare_vm_disks.sh"
  container_name       = "new"
  str_name             = "dp200sd"
  keys                 = var.keys

}

```
### Exemplo de código
Terraform 0.14.x
``` Go
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # module.rg.azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus2"
      + name     = "rg-impulse-datacollection-dev"
    }

  # module.vm-linux.data.azurerm_resource_group.vm-linux will be read during apply
  # (config refers to values not yet known)
 <= data "azurerm_resource_group" "vm-linux"  {
      + id       = (known after apply)
      + location = (known after apply)
      + name     = "rg-impulse-datacollection-dev"
      + tags     = (known after apply)

      + timeouts {
          + read = (known after apply)
        }
    }

  # module.vm-linux.azurerm_linux_virtual_machine.vm-linux will be created
  + resource "azurerm_linux_virtual_machine" "vm-linux" {
      + admin_username                  = "azuretfuser"
      + allow_extension_operations      = true
      + computer_name                   = (known after apply)
      + disable_password_authentication = true
      + extensions_time_budget          = "PT1H30M"
      + id                              = (known after apply)
      + location                        = "eastus2"
      + max_bid_price                   = -1
      + name                            = "vm-dev-store-bemol"
      + network_interface_ids           = (known after apply)
      + platform_fault_domain           = -1
      + priority                        = "Regular"
      + private_ip_address              = (known after apply)
      + private_ip_addresses            = (known after apply)
      + provision_vm_agent              = true
      + public_ip_address               = (known after apply)
      + public_ip_addresses             = (known after apply)
      + resource_group_name             = "rg-impulse-datacollection-dev"
      + size                            = "Standard B2ms"
      + virtual_machine_id              = (known after apply)
      + zone                            = (known after apply)

      + admin_ssh_key {
          + public_key = <<-EOT
                ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLC3IsrFfOeLCJBMe2VQSAytECA56vDwqGR7BiFsxni0+8CxHcOCOGni3x6b5s9lZg0G/KCIwFLtS4DIFwL6vokJFmJDSqov3yc3g8MCg0Zi1HSsu4FsS0cbzDs8iXcuwWX8o9mNU7QrScoTSe8971IjPyYdDLcJC1E4tMfdAgIB7fTpMwFm1yfLsS6dezBI7qpERedDTOUsGyK9B45ki+MqbcpBNouOS37nK+rQumKR6NkxjEOb3T7Ta/FDufiZZ/36SS6B87g6YOEt5yhwqZAMaNyvgIRhZ/phDZIGIkGIL85mRSXyNgnFEKKbHlIZZj3dCmT+cmwnpKLRro6MLAL39pzajehgIQfx5fe/lVY/iJOFw+JbstOiz8/bSQCuOMG2EkiYhe72O+FViQCGpe7NIOxLnpB0RAwUHr8NK5dwPO6CYoHmKrVet6Z6/jsvTPtCyARBE8VV+YPQSZUmeur3uQRx1LlF+LCY0bUkIWRAga3o31BVabXMOoutwLqck= felipe.rezende@softwareone.com
            EOT
          + username   = "azuretfuser"
        }

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "UbuntuServer"
          + publisher = "Canonical"
          + sku       = "18.04-LTS"
          + version   = "latest"
        }
    }

  # module.vm-linux.azurerm_network_interface.vmnic will be created
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
      + name                          = "vm-dev-store-bemol-nic"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "rg-impulse-datacollection-dev"
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + name                          = "vm-dev-store-bemol-nic-config"
          + primary                       = true
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = "static"
          + private_ip_address_version    = "IPv4"
          + subnet_id                     = "/subscriptions/8fd9e3e0-82a3-488b-8918-c5543d717c72/resourceGroups/rg-lnx-tfstates/providers/Microsoft.Network/virtualNetworks/vn-lnx/subnets/sn-teste"
        }
    }

Plan: 3 to add, 0 to change, 0 to destroy.

```



Clique [**aqui**](../../README.md) para voltar para a página principal da documentação.
