# Variáveis gerais

variable "resource_group_name" {
  type = string
}

variable "vnet_resource_group_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "node_subnet" {
  type = string
}

variable "location" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(any)
  default = {}
}

# Variáveis do AKS
variable "app_id" {
  type    = string
  default = null
}

variable "password" {
  type    = string
  default = null
}

variable "k8s_version" {
  type    = string
  default = "1.19.9"
}
variable "node_name" {
  type    = string
  default = "default"
}

variable "node_vm_count" {
  type    = number
  default = 2
}

variable "max_pods" {
  type    = number
  default = 30
}

variable "node_vm_disk_size" {
  type    = number
  default = 30
}

variable "node_vm_size" {
  type    = string
  default = "standard_d2s_v3"
}

variable "node_av_zone" {
  type    = list(number)
  default = [1, 2, 3]
}

variable "dns_name" {
  type    = string
  default = "service"
}

variable "default_node_settings" {
  type    = map(any)
  default = {}
}

variable "enable_autoscaling" {
  type    = bool
  default = false
}

variable "aks_network_cidr" {
  type = string
}

variable "aks_docker_bridge" {
  type = string
}

variable "aks_dns_ip" {
  type = string
}

variable "additional_node_pools" {
  description = "The map object to configure one or several additional node pools with number of worker nodes, worker node VM size and Availability Zones."
  type = map(object({
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
  type    = bool
  default = false
}
