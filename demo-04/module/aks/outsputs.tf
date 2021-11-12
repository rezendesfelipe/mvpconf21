output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_dns_name" {
  value = azurerm_kubernetes_cluster.aks.dns_prefix
}

output "kube_admin_config" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config
}

output "kube_config_raw" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "addon_profile" {
  value = azurerm_kubernetes_cluster.aks.addon_profile
}

output "identity" {
  value = azurerm_kubernetes_cluster.aks.identity
}