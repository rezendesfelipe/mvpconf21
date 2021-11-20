# Nome do cluster AKS
output "aks_cluster_name" {
  value       = module.aks_mvpconf21.aks_cluster_name
  description = "Nome do Cluster de Kubernetes."
}

# Nome de DNS do AKS
output "aks_dns_name" {
  value       = module.aks_mvpconf21.aks_dns_name
  description = "DNS Name designado para o cluster Kubernetes"
}

output "kube_admin_config" {
  value       = module.aks_mvpconf21.kube_admin_config
  description = "Configurações de Administrador do Kubernetes."
}

output "kube_config_raw" {
  value       = module.aks_mvpconf21.kube_config_raw
  sensitive   = true
  description = "100% de todas as informações do cluster"
}

output "addon_profile" {
  value       = module.aks_mvpconf21.addon_profile
  description = "Informações sobre o Addon Profile do AKS"
}

output "identity" {
  value       = module.aks_mvpconf21.identity
  description = "Managed Identity do AKS."
}

output "acr_login_server" {
  value       = module.acr_mvpconf21.acr_login_server
  description = "Identificador do Azure Container Registry."
}
