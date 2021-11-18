variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group"
}

variable "metric_name" {
  type    = string
  default = "Percentage CPU"
}

variable "subnet_name" {
  type        = string
  description = "Nome da Subnet"
}

variable "eviction_policy" {
  type    = string
  default = null
}


variable "vnet_name" {
  description = "The name of the virtual network"
  default     = ""
}

variable "vmssl_name" {
  type        = string
  description = "Nome do Scale Set Linux"
}

variable "admin_username" {
  type        = string
  description = "Usuário administrador"
}

variable "instances" {
  type        = number
  description = "Número de instâncias"
}

variable "sku" {
  type        = string
  description = "Nome do SKU"
}

variable "network_interface_name" {
  type        = string
  description = "Nome que deve ser utilizado para a Network Interface"
}

variable "network_interface_primary" {
  type        = bool
  description = "Informa se a interface de rede é primária"
  default     = true
}

variable "network_interface_ip_config_name" {
  type        = string
  description = "Nome da configuração a ser utilizada"
  default     = "internal"
}

variable "network_interface_ip_application_gateway_backend_ids" {
  type        = list(string)
  description = "Lista de IDs de Backend Address Pools de um Application Gateway que este recurso deve se conectar"
  default     = []
}

variable "network_interface_ip_load_balancer_backend_ids" {
  type        = list(string)
  description = "Lista de IDs de Backend Address Pools de um Load Balancer que este recurso deve se conectar"
  default     = []
}

variable "network_interface_ip_load_balancer_inbound_nat_rules_ids" {
  type        = list(string)
  description = "Lista de IDs de regras NAT de um Load Balancer"
  default     = []
}

variable "network_interface_ip_config_primary" {
  type        = bool
  description = "Informa se a configuracao de IP da rede e primaria"
  default     = true
}

variable "network_interface_enable_accelerated_networking" {
  type        = bool
  description = "Especifica se o Accelerated Networking será habilitado"
  default     = false
}

variable "os_disk_size" {
  type        = number
  description = "Especifica o tamanho do disco de sistema operacional"
  default     = null
}

variable "os_disk_caching" {
  type        = string
  description = "Caching do disco de sistema operacional"
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  type        = string
  description = "Tipo da storage account do disco de sistema operacional. Os possíveis valores são: Standard_LRS, StandardSSD_LRS, Premium_LRS e UltraSSD_LRS"
  default     = "Standard_LRS"
}

variable "additional_capabilities_ultra_ssd_enabled" {
  type        = bool
  description = "Especifica se UltraSSD_LRS para discos será habilitado"
  default     = false
}

variable "admin_ssh_public_key" {
  type        = string
  sensitive   = true
  description = "Chave pública SSH"
}

variable "boot_diagnostics_storage_account_uri" {
  type        = string
  description = "Endpoint para uma Storage Account que deve ser utilizada para armazenar logs de boot."
  default     = null
}

variable "data_disks" {
  type        = list(any)
  description = "Lista de discos de dados"
  default     = []
}

variable "encryption_at_host_enabled" {
  type        = bool
  description = "Especifica se todos os discos devem ser criptografados"
  default     = false
}

variable "platform_fault_domain_count" {
  type        = number
  description = "Número de fault domains a serem utilizados"
  default     = null
}

variable "priority" {
  type        = string
  description = "Prioridade a ser utilizada. Aceita Regular e Spot"
  default     = "Regular"
}

variable "provision_vm_agent" {
  type        = bool
  description = "Especifica se o Azure VM Agent deve ser provisionado em cada máquina"
  default     = true
}

variable "scale_in_policy" {
  type        = string
  description = "Política de scale-in. Aceita Default, NewestVM e OldestVM"
  default     = "Default"
}

variable "custom_image_enabled" {
  type        = bool
  description = "Define se uma imagem gerenciada será utilizada. Caso sim, a variável custom_image_id deve ser definida"
  default     = false
}

variable "custom_image_id" {
  type        = string
  description = "ID da imagem gerenciada a ser utilizada"
  default     = null
}

variable "image_publisher" {
  type        = string
  description = "Publisher da imagem"
  default     = null
}

variable "image_offer" {
  type        = string
  description = "Nome da imagem"
  default     = null
}

variable "image_sku" {
  type        = string
  description = "SKU da imagem"
  default     = null
}

variable "image_version" {
  type        = string
  description = "Versao da imagem"
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "Tags a serem aplicadas no Scale Set Linux"
  default     = {}
}

variable "terminate_notification_enabled" {
  type        = bool
  description = "Especifica se uma notificação de término será habilitada"
  default     = false
}

variable "terminate_timeout" {
  type        = string
  description = "Tempo para notificação de término ser enviada. Aceita entre 5 e 15"
  default     = "P10S"
}

variable "zone_balance" {
  type        = bool
  description = "Especifica se as máquinas devem ser balanceadas entre zonas de disponibilidade"
  default     = false
}

variable "zones" {
  type        = list(string)
  description = "Lista de zonas de disponibilidade que as máquinas devem ser criadas"
  default     = []
}

variable "scale_number" {
  description = "The number of instanced that will be decreased"
  type        = number
  default     = 1
}

variable "minimum_instances_count" {
  description = "The minimum number of instances for this resource. Valid values are between 0 and 1000"
  default     = null
}

variable "maximum_instances_count" {
  description = "The maximum number of instances for this resource. Valid values are between 0 and 1000"
  default     = ""
}
variable "enable_autoscale_for_vmss" {
  description = "Manages a AutoScale Setting which can be applied to Virtual Machine Scale Sets"
  default     = false
}

variable "profile_name" {
  type    = string
  default = "Default"
}

variable "profiles" {
  type    = list(any)
  default = []
}
variable "vnet_resource_group_name" {
  type = string

}
variable "single_placement_enabled" {
  type    = bool
  default = true
}

variable "keys" {
  description = "Access Key da storage account responsavel por armazenar o Script"
  type        = string
  default     = null
}
variable "ext_name" {
  description = "Extension name"
  type        = string
  default     = null
}
variable "script_name" {
  type    = string
  default = null
}
variable "container_name" {
  type    = string
  default = null
}
variable "command_exec" {
  description = "linha de comando que irá exec o script, ex: ./prepare_vm_disks.sh"
  type        = string
  default     = null
}
variable "str_name" {
  type    = string
  default = null
}
variable "is_extension_enabled" {
  type        = bool
  default     = false
  description = "Especifica se a VM terá extensão habilitada."
}

variable "handler_version" {
  type    = string
  default = null
}

# variable "encode_script" {
#   type = string
# }
