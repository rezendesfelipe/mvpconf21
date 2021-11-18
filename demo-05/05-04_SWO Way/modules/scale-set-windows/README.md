# Módulo de Scale Set Windows
## Variáveis válidas
Este módulo aceita as seguintes variáveis:
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `vmssw_name`: Nome do Scale Set Windows, só pode ter até 9 caracteres.
* [Obrigatório] `admin_password`: Senha do Usuário Administrador.
* [Obrigatório] `admin_username`: Usuário administrador.
* [Obrigatório] `instances`: Número de instâncias.
* [Obrigatório] `sku`: Nome do SKU.
* [Obrigatório] `network_interface_name`: Nome que deve ser utilizado para a Network Interface.
* [Obrigatório] `network_interface_ip_config_subnet_id`: ID da subnet.
* [Obrigatório] `platform_fault_domain_count`: Número de fault domains a serem utilizados.
* [Obrigatório] `image_publisher`: Publisher da imagem.
* [Obrigatório] `image_offer`: Nome da imagem.
* [Obrigatório] `image_sku`: SKU da imagem.
* [Obrigatório] `image_version`: Versao da imagem.
* [Opcional] `network_interface_primary`: Informa se a interface de rede é primária.
* [Opcional] `network_interface_ip_config_name`: Nome da configuração a ser utilizada.
* [Opcional] `network_interface_ip_application_gateway_backend_ids`: Lista de IDs de Backend Address Pools de um Application Gateway que este recurso deve se conectar.
* [Opcional] `network_interface_ip_load_balancer_backend_ids`: Lista de IDs de Backend Address Pools de um Load Balancer que este recurso deve se conectar.
* [Opcional] `network_interface_ip_load_balancer_inbound_nat_rules_ids`: "Lista de IDs de regras NAT de um Load Balancer.
* [Opcional] `network_interface_ip_config_primary`: Informa se a configuracao de IP da rede e primaria.
* [Opcional] `network_interface_enable_accelerated_networking`: Especifica se o Accelerated Networking será habilitado.
* [Opcional] `os_disk_caching`: Caching do disco de sistema operacional.
* [Opcional] `os_disk_storage_account_type`: Tipo da storage account do disco de sistema operacional. Os possíveis valores são: Standard_LRS, StandardSSD_LRS, Premium_LRS e UltraSSD_LRS.
* [Opcional] `additional_capabilities_ultra_ssd_enabled`: Especifica se UltraSSD_LRS para discos será habilitado.
* [Opcional] `boot_diagnostics_storage_account_uri`: Endpoint para uma Storage Account que deve ser utilizada para armazenar logs de boot.
* [Opcional] `data_disks`: Lista de discos de dados.
* [Opcional] `encryption_at_host_enabled`: Especifica se todos os discos devem ser criptografados.
* [Opcional] `priority`: Prioridade a ser utilizada. Aceita Regular e Spot.
* [Opcional] `provision_vm_agent`: Especifica se o Azure VM Agent deve ser provisionado em cada máquina.
* [Opcional] `scale_in_policy`: Política de scale-in. Aceita Default, NewestVM e OldestVM.
* [Opcional] `tags`: Tags a serem aplicadas no Scale Set Linux.
* [Opcional] `terminate_notification_enabled`: Especifica se uma notificação de término será habilitada.
* [Opcional] `terminate_timeout`: Tempo para notificação de término ser enviada. Aceita entre 5 e 15.
* [Opcional] `zone_balance`: Especifica se as máquinas devem ser balanceadas entre zonas de disponibilidade.
* [Opcional] `zones`: Lista de zonas de disponibilidade que as máquinas devem ser criadas.

## Ouputs gerados pelo módulo
* `scale_set_windows_id`: id do scale set
* `scale_set_windows_identity`: id do service principal
* `scale_set_windows_unique_id`: id único do scale set

## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "vmssw" {
  source                                = "../../../modules/scale-set-windows"
  resource_group_name                   = modules.rg.rg_name
  vnet_name                             = modules.vnet.vnet_name
  subnet_name                           = modules.vnet.vnet_subnet_names[5]
  vmssw_name                            = "vmssw"  
  admin_username                        = "adminuser"
  admin_password                        = "P2ssw0rd@123" 
  instances                             = 1 
  sku                                   = "Standard_F2"
  network_interface_name                = "vmss-nic"

  data_disks = [
    {
      caching              = "ReadWrite"
      create_option        = "Empty"
      disk_size_gb         = 10
      lun                  = 0
      storage_account_type = "Standard_LRS"
    },
    {
      caching              = "ReadWrite"
      create_option        = "Empty"
      disk_size_gb         = 10
      lun                  = 1
      storage_account_type = "Standard_LRS"
    }
  ]

  platform_fault_domain_count = 1
  
  image_publisher = "MicrosoftWindowsServer"
  image_offer     = "WindowsServer"
  image_sku       = "2016-Datacenter-Server-Core"
  image_version   = "latest"

  tags = {
    Ambiente      = "Desenvolvimento"
    Departamento  = "Platform"
    Centro_Custo  = 12345
  }

  depends_on      = [modules.vnet, modules.rg]
}
```
### Exemplo de plan
<details><summary>Expanda para ver o exemplo</summary>

``` Go
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.vmssw.azurerm_windows_virtual_machine_scale_set.vmssw will be created
  + resource "azurerm_windows_virtual_machine_scale_set" "vmssw" {
      + admin_password                                    = (sensitive value)
      + admin_username                                    = "adminuser"
      + computer_name_prefix                              = (known after apply)
      + do_not_run_extensions_on_overprovisioned_machines = false
      + enable_automatic_updates                          = true
      + encryption_at_host_enabled                        = false
      + extensions_time_budget                            = "PT1H30M"
      + id                                                = (known after apply)
      + instances                                         = 1
      + location                                          = "eastus"
      + max_bid_price                                     = -1
      + name                                              = "vmssw"
      + overprovision                                     = true
      + platform_fault_domain_count                       = 1
      + priority                                          = "Regular"
      + provision_vm_agent                                = true
      + resource_group_name                               = "rg-terraform"
      + scale_in_policy                                   = "Default"
      + single_placement_group                            = true
      + sku                                               = "Standard_F2"
      + tags                                              = {
          + "Ambiente"     = "Desenvolvimento"
          + "Centro_Custo" = "12345"
          + "Departamento" = "Platform"
        }
      + unique_id                                         = (known after apply)
      + upgrade_mode                                      = "Manual"
      + zone_balance                                      = false
      + zones                                             = []

      + additional_capabilities {
          + ultra_ssd_enabled = false
        }

      + automatic_instance_repair {
          + enabled      = (known after apply)
          + grace_period = (known after apply)
        }

      + boot_diagnostics {}

      + data_disk {
          + caching                   = "ReadWrite"
          + create_option             = "Empty"
          + disk_iops_read_write      = (known after apply)
          + disk_mbps_read_write      = (known after apply)
          + disk_size_gb              = 10
          + lun                       = 0
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }
      + data_disk {
          + caching                   = "ReadWrite"
          + create_option             = "Empty"
          + disk_iops_read_write      = (known after apply)
          + disk_mbps_read_write      = (known after apply)
          + disk_size_gb              = 10
          + lun                       = 1
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + extension {
          + auto_upgrade_minor_version = (known after apply)
          + force_update_tag           = (known after apply)
          + name                       = (known after apply)
          + protected_settings         = (sensitive value)
          + provision_after_extensions = (known after apply)
          + publisher                  = (known after apply)
          + settings                   = (known after apply)
          + type                       = (known after apply)
          + type_handler_version       = (known after apply)
        }

      + network_interface {
          + enable_accelerated_networking = false
          + enable_ip_forwarding          = false
          + name                          = "vmss-nic"
          + primary                       = true

          + ip_configuration {
              + name      = "internal"
              + primary   = true
              + subnet_id = "/subscriptions/4599b013-ba27-4284-9a04-637b49f73370/resourceGroups/rg-terraform/providers/Microsoft.Network/virtualNetworks/vnet-terraform/subnets/default"
              + version   = "IPv4"
            }
        }

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "WindowsServer"
          + publisher = "MicrosoftWindowsServer"
          + sku       = "2016-Datacenter-Server-Core"
          + version   = "latest"
        }

      + terminate_notification {
          + enabled = (known after apply)
          + timeout = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + scale_set_windows_id        = (known after apply)
  + scale_set_windows_identity  = (known after apply)
  + scale_set_windows_unique_id = (known after apply)
```
</details>

<br/>

Clique [**aqui**](../../README.md) para voltar para a página principal da documentação.
