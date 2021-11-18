# Módulo de Scale Set Linux
## Variáveis válidas
Este módulo aceita as seguintes variáveis:
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `vmssl_name`: Nome do Scale Set Linux.
* [Obrigatório] `admin_username`: Usuário administrador.
* [Obrigatório] `instances`: Número de instâncias.
* [Obrigatório] `sku`: Nome do SKU.
* [Obrigatório] `network_interface_name`: Nome que deve ser utilizado para a Network Interface.
* [Obrigatório] `network_interface_ip_config_subnet_id`: ID da subnet.
* [Obrigatório] `admin_ssh_public_key`: Chave pública SSH.
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
* [Opcional] `os_disk_size`: Especifica o tamanho do disco do Sistema operacional
* [Opcional] `os_disk_caching`: Caching do disco de sistema operacional.
* [Opcional] `os_disk_storage_account_type`: Tipo da storage account do disco de sistema operacional. Os possíveis valores são: Standard_LRS, StandardSSD_LRS, Premium_LRS e UltraSSD_LRS.
* [Opcional] `additional_capabilities_ultra_ssd_enabled`: Especifica se UltraSSD_LRS para discos será habilitado.
* [Opcional] `boot_diagnostics_storage_account_uri`: Endpoint para uma Storage Account que deve ser utilizada para armazenar logs de boot. Utilizar um valor nulo irá gerar utilizar uma conta de armazenamento gerenciada.
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
## Variáveis responsaveis pelo monitoramento do scale set 
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `name`: O nome da configuração AutoScale.
* [Obrigatório] `location`: Especifica o local do Azure com suporte onde a configuração de AutoScale deve existir.
* [Obrigatório] `profile_name`: Especifica um ou mais (até 20) profile blocos conforme definido abaixo.
* [Obrigatório] `target_resource_id`: Especifica a ID do recurso ao qual a configuração de dimensionamento automático deve ser adicionada.
* [Obrigatório] `minimum_instances_count`: O número mínimo de instâncias para este recurso. Os valores válidos estão entre 0e 1000.
* [Obrigatório] `maximum_instances_count`: O número máximo de instâncias para este recurso. Os valores válidos estão entre 0e 1000.
* [Opcional]`enable_autoscale_for_vmss`: Boolean que irá liberar a opção de utilizar os blocos de Scale do scale set.
## Tips and Tricks sobre o bloco rule
O bloco possui diversas variáveis que irão mudar de acordo com sua necessidade, segue segue aqui algumas dicas sobre como atuar com elas:
`metric name`: Representa com qual tipo de metrica sua regra irá trabalhar, neste caso estamos utilizando como [default] "Percentage CPU", sendo assim sempre que suas vms atingirem o threashold da CPU o scale in ou out irá iniciar.
[All metric availables](https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftcomputevirtualmachinescalesets)

`time grain`: O tempo total que será aguardado até que a regra de scale possa iniciar novamente.

`time window`: O tempo total que o mecanismo irá buscar em suas métricas para saber a necessidade de fazer scale in ou out.


## Ouputs gerados pelo módulo
* `scale_set_linux_id`: id do scale set
* `scale_set_linux_identity`: id do service principal
* `scale_set_linux_unique_id`: id único do scale set


## Casos de uso
### Exemplo como adicionar novas "rules"
``` Go
/*Sempre que haver a necessidade de adicionar uma nova regra increase, ela deverá ser feita utilizando os "}{", como no exemplo abaixo, sempre utilizando seu respectivo bloco.*/

rules_Increase = [
        {
          time_grain       = "PT1M"
          statistic        = "Average"
          time_window      = "PT5M"
          time_aggregation = "Average"
          operator         = "GreaterThanOrEqual"
          scale_threshold  = 80
          direction        = "Increase"
          type             = "ChangeCount"
          scale_number     = 1
          cooldown         = "PT1M"
        },
        {
          time_grain       = "PT1M"
          statistic        = "Average"
          time_window      = "PT5M"
          time_aggregation = "Average"
          operator         = "GreaterThanOrEqual"
          scale_threshold  = 86
          direction        = "Increase"
          type             = "ChangeCount"
          scale_number     = 1
          cooldown         = "PT1M"
        }
      ]
      rules_Decrease = [
        {
          time_grain       = "PT1M"
          statistic        = "Average"
          time_window      = "PT5M"
          time_aggregation = "Average"
          operator         = "GreaterThanOrEqual"
          scale_threshold  = 40
          direction        = "Decrease"
          type             = "ChangeCount"
          scale_number     = 1
          cooldown         = "PT1M"
        },
        {
          time_grain       = "PT1M"
          statistic        = "Average"
          time_window      = "PT5M"
          time_aggregation = "Average"
          operator         = "GreaterThanOrEqual"
          scale_threshold  = 20
          direction        = "Decrease"
          type             = "ChangeCount"
          scale_number     = 1
          cooldown         = "PT1M"
        }
      ]
    }
  ]
```
## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "vmssl" {
  source = "../terraform-cloud/modules/scale-set-linux"

  resource_group_name    = module.rg.rg_name
  vnet_name              = module.vnet.vnet_name
  sn_id                  = module.vnet.vnet_subnet_ids[0]
  subnet_name            = module.vnet.vnet_subnet_names[0]
  vmssl_name             = "vmss-linux"
  admin_username         = "adminuser"
  instances              = 1
  sku                    = "Standard_F2"
  network_interface_name = "vmss-nic"
  admin_ssh_public_key   = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJe7KncJ5x3u/A3UIWGb6Egz08KZwMSxZvFup2JqU2KT9q2CckNAv8vlU113s/rLZNxtoreZfwvWSGZdRkUGwF0m8e5bnX4qoUNFo9JGArl0ldPFNJaExcEnEXrWbFNBrH891VJ+RcnD9YRJqQiYUIJvGCnCBXJhJIw4Gj3XCPA9mrVizlEWRN0tK1C31P6Vqw17kMaOJCVe298O1pPr12ORcpiAB2xM/Ipxj+Y7m30itCeLm0H1KH4jq6fwKUub4Tnv+lRW6BjT4XeSME2iFZAEo9mfhWik6SPiChWvo9RICzWLr9tmNkcrbyaegB/No5FlEUo3LfOck6asSn4Djz cristina@cc-444db6ed-5b6dccbbc5-pll8z"
  profile_name           = "scalePolicy"
  metric_name            = "Percentage CPU"

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

  image_publisher           = "Canonical"
  image_offer               = "UbuntuServer"
  image_sku                 = "16.04-LTS"
  image_version             = "latest"
  enable_autoscale_for_vmss = true
  minimum_instances_count   = 1
  maximum_instances_count   = 5
  profiles = [
    {
      name    = "TestProfile"
      minimum = 1
      maximum = 5
      rules_Increase = [
        {
          time_grain       = "PT1M"
          statistic        = "Average"
          time_window      = "PT5M"
          time_aggregation = "Average"
          operator         = "GreaterThanOrEqual"
          scale_threshold  = 80
          direction        = "Increase"
          type             = "ChangeCount"
          scale_number     = 1
          cooldown         = "PT1M"
        }
      ]
      rules_Decrease = [
        {
          time_grain       = "PT1M"
          statistic        = "Average"
          time_window      = "PT5M"
          time_aggregation = "Average"
          operator         = "GreaterThanOrEqual"
          scale_threshold  = 40
          direction        = "Decrease"
          type             = "ChangeCount"
          scale_number     = 1
          cooldown         = "PT1M"
        }
      ]
    }
  ]



  tags = {
    suite       = "impulse/commerce"
    produto     = "search/platform/commerce/hub"
    env         = "dev/stg/hlg/prd"
    provisioner = "terraform"
    team        = "cloud/search/wishlist"
  }
  depends_on = [module.vnet, module.rg]
}
```
