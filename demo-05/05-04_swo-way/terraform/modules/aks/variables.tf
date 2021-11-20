# Variáveis gerais

variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group."
}

variable "vnet_resource_group_name" {
  type        = string
  description = "Resource Group da rede virtual."
}

variable "vnet_name" {
  type        = string
  description = "Nome da VNET"
}

variable "node_subnet" {
  type        = string
  description = "Subnet do default node."
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "localidade em que será criado o Kubernetes Service."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de tags pra rotular os recursos do Kubernetes Services."
}

# Variáveis do AKS
variable "app_id" {
  type        = string
  default     = null
  description = "Application ID da service principal que irá governar o Kubernetes Service."
}

variable "password" {
  type        = string
  default     = null
  description = "Application Secret da service principal que irá governar o Kubernetes Services."
}

variable "k8s_version" {
  type        = string
  default     = "1.19.9"
  description = "Versão do Kubernetes para o Kubernetes Services."
}
variable "node_name" {
  type        = string
  default     = "default"
  description = "Nome do Default node do Kubernetes Services."
}

variable "node_vm_count" {
  type        = number
  default     = 2
  description = "Número de Nodes (VMs) que serão criados para o default node do Kubernetes Services."
}

variable "max_pods" {
  type        = number
  default     = 30
  description = "Quantidade máxima de Pods por node (dentro do Default node)."
}

variable "node_vm_disk_size" {
  type        = number
  default     = 30
  description = "Tamanho em GB do disco de SO do Node"
}

variable "node_vm_size" {
  type        = string
  default     = "Standard_d2s_v3"
  description = "Size da VM do default node"
}

variable "node_av_zone" {
  type    = list(number)
  default = [1, 2, 3]
}

variable "dns_name" {
  type        = string
  default     = "service"
  description = "Node de DNS do cluster de Kubernetes."
}

variable "default_node_settings" {
  type        = map(any)
  default     = {}
  description = "Configurações de `max_nodes` e `min_nodes` quando a opção `enable_autoscaling` está definida como `true`."
}

variable "enable_autoscaling" {
  type        = bool
  default     = false
  description = "Habilita ou não as opções de autoscaling do default node pool."
}

variable "aks_network_cidr" {
  type        = string
  description = "Endereço CIDR da rede do Kubernetes Service."
}

variable "aks_docker_bridge" {
  type        = string
  description = "endereço CIDR para ser usado como Docker Bridge."
}

variable "aks_dns_ip" {
  type        = string
  description = "IP do DNS (deve estar dentro do range de IP do `aks_network_cidr`)."
}

variable "additional_node_pools" {
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

variable "is_identity_enabled" {
  type        = bool
  default     = false
  description = "Habilitar ou não o uso de identidade gerenciada."
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

variable "enable_attach_acr" {
  type        = bool
  default     = false
  description = "Força o attach ou não do Kubernetes Services com o Azure Container Services (Obrigatório verificar a documentação adequada)"
}

variable "enable_log_analytics_workspace" {
  type        = bool
  default     = false
  description = "Habilita ou não o uso do Log Analytics. Neste momento não é possível associar a um Log Analytics Workspace existente."
}

variable "log_analytics_workspace_name" {
  type        = string
  default     = null
  description = "nome do workspace do Log Analytics. É obrigatório caso `enable_log_analytics_workspace` for marcado como `true`"
}

variable "log_analytics_workspace_sku" {
  type        = string
  default     = "PerGB2018"
  description = "Define a SKU utilizada pelo Log Analytics Workspace."
}

variable "log_retention_in_days" {
  type        = number
  default     = 30
  description = "Define o número de dias em que os logs serão armazenados no Workspace."
}

variable "enable_monitoring_agent" {
  type        = bool
  default     = true
  description = "Uso legado para habilitar monitoramento. Vide linha 82 em main.tf do commit **[acdf68f8]**."
}

variable "enable_azure_policy" {
  type        = bool
  default     = false
  description = "Habilitar ou não o add-on de Azure Policy para Kubernetes."
}

variable "enable_http_application_routing" {
  type        = bool
  default     = true
  description = "Habilitar ou não Roteamento HTTP de Aplicação."
}

variable "enable_role_based_access_control" {
  type        = bool
  default     = true
  description = "Habilitar ou não RBAC para Kubernetes."
}
variable "enable_azure_active_directory" {
  type        = bool
  default     = false
  description = "Habilitar ou não Integração com Azure Active Directory."
}

variable "rbac_aad_managed" {
  type        = bool
  default     = false
  description = "Habilitar ou não gestão de RBAC de Azure AD Gerenciado."
}

variable "rbac_aad_admin_group_object_ids" {
  description = "Object ID of groups with admin access."
  type        = list(string)
  default     = null
}

variable "acr_id" {
  type        = string
  default     = ""
  description = "ID do ACR a ser integrado com o AKS."
}

variable "is_private_cluster_enabled" {
  type        = bool
  default     = false
  description = "Habilita que o cluster teha suas APIs dipostas somente para a rede interna"

}
variable "host_encryption" {
  type        = bool
  default     = false
  description = "Habilita criptografia no default node pool"

}
