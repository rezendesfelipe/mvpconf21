#----------------------
# Global Vars
#----------------------

variable "resource_group_name" {
  type        = string
  description = "O nome do seu Resource Group"
}

variable "location" {
  type        = string
  description = "A região do datacenter onde seus recursos serão criados."
  default     = "brazilsouth"
}

variable "tags" {
  type        = any
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos dos recursos."
}

#----------------------
# RBAC Vars
#----------------------
variable "developers_group_name" {
  type        = string
  description = "Display Name do grupo de segurança que receberá a função no Resource Group."
}

variable "developers_group_role" {
  type        = string
  description = "Role que o grupo de segurança que receberá no Resource Group."
}

variable "_group_name" {
  type        = string
  description = "Display Name do grupo de segurança que receberá a função no Resource Group."
}

variable "_group_role" {
  type        = string
  description = "Role que o grupo de segurança que receberá no Resource Group."
}

#----------------------
# Virtual Network Vars
#----------------------

variable "vnet_name" {
  type        = string
  description = "Nome da Rede virtual a ser consumida pelo AKS."
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Lista de todos os address spaces que serão usados pelo AKS."
}

variable "subnets" {
  type        = any
  description = "Mapa de caracteres que deve conter as informações da sua subnet. Para referências e como usar consulte o [Módulo VNET](../../modules/vnet/README.md)."
}

variable "vnet_peering_settings" {
  type        = any
  default     = null
  description = "Mapa de caracteres apresentando as configurações de peering. `Key` é o nome da conexão e `value` deve conter `remove_vnet_id` e o valor deve ser o Resource Id da VNET de destino."
}

#----------------------
# AKS Vars
#----------------------

variable "aks_dns_name" {
  type        = string
  description = "Definição do nome que será utilizado para o AKS e também dns do cluster"
}

variable "aks_is_identity_enabled" {
  type        = bool
  description = "Habilitar ou não o uso de identidade gerenciada."
}


variable "aks_node_subnet" {
  type        = string
  description = "Subnet do default node."
}

variable "aks_k8s_version" {
  type        = string
  description = "Versão do Kubernetes para o Kubernetes Services."
}
variable "aks_node_name" {
  type        = string
  default     = "default"
  description = "Nome do Default node do Kubernetes Services."
}

variable "aks_node_vm_count" {
  type        = number
  default     = 2
  description = "Número de Nodes (VMs) que serão criados para o default node do Kubernetes Services."
}

variable "aks_max_pods" {
  type        = number
  default     = 30
  description = "Quantidade máxima de Pods por node (dentro do Default node)."
}

variable "aks_node_vm_disk_size" {
  type        = number
  default     = 30
  description = "Tamanho em GB do disco de SO do Node"
}

variable "aks_node_vm_size" {
  type        = string
  description = "Size da VM do default node"
}

variable "aks_node_av_zone" {
  type    = list(number)
  default = [1, 2, 3]
}

variable "aks_default_node_settings" {
  type        = map(any)
  default     = {}
  description = "Configurações de `max_nodes` e `min_nodes` quando a opção `enable_autoscaling` está definida como `true`."
}

variable "aks_enable_autoscaling" {
  type        = bool
  description = "Habilita ou não as opções de autoscaling do default node pool."
}

variable "default_aks_network_cidr" {
  type        = string
  description = "Endereço CIDR da rede do Kubernetes Service."
}

variable "default_aks_docker_bridge" {
  type        = string
  description = "endereço CIDR para ser usado como Docker Bridge."
}

variable "default_aks_dns_ip" {
  type        = string
  description = "IP do DNS (deve estar dentro do range de IP do `aks_network_cidr`)."
}

variable "aks_additional_node_pools" {
  description = "O mapa de objetos para configurar um ou mais node pools adicinais com um número de VMs, seus sizes e Disponibilidade de zona."
  type = map(object({
    additional_node_name           = string
    node_count                     = number
    vm_size                        = string
    zones                          = list(string)
    max_pods                       = number
    os_disk_size                   = number
    node_os                        = string
    cluster_auto_scaling           = bool
    cluster_auto_scaling_min_count = number
    cluster_auto_scaling_max_count = number
    enable_public_ip               = bool
  }))
  default = {}

}

variable "aks_network_plugin" {
  type        = string
  default     = "azure"
  description = "Nome do Network plugin usado pelo Kubernetes Services. Use `azure` para a rede avançada (Azure CNI) ou `kubenet` para a rede básica."
}

variable "aks_network_policy" {
  type        = string
  default     = "azure"
  description = "Nome da Network Policy usada pelo Kubernete Services. Utilize `azure`, `calico` ou `none`."
}

variable "aks_enable_attach_acr" {
  type        = bool
  description = "Força o attach ou não do Kubernetes Services com o Azure Container Services (Obrigatório verificar a documentação adequada)"
}

variable "aks_enable_log_analytics_workspace" {
  type        = bool
  description = "Habilita ou não o uso do Log Analytics. Neste momento não é possível associar a um Log Analytics Workspace existente."
}

variable "aks_log_analytics_workspace_name" {
  type        = string
  default     = null
  description = "nome do workspace do Log Analytics. É obrigatório caso `enable_log_analytics_workspace` for marcado como `true`"
}


variable "aks_enable_azure_active_directory" {
  type        = bool
  default     = false
  description = "Habilitar ou não Integração com Azure Active Directory."
}

variable "aks_rbac_aad_managed" {
  type        = bool
  description = "Habilitar ou não gestão de RBAC de Azure AD Gerenciado."
}

variable "aks_rbac_aad_admin_group_object_ids" {
  description = "Object ID of groups with admin access."
  type        = list(string)
}

#----------------------
# ACR Vars
#----------------------

variable "acr_name" {
  type        = string
  description = "Nome do Registro de Container. Precisa ser um nome único porque a partir daqui será gerado o nome do registry."
}

variable "acr_enable_admin" {
  type        = string
  description = ""
}
