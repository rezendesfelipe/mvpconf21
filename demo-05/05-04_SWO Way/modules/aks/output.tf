output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_dns_name" {
  value = azurerm_kubernetes_cluster.aks.dns_prefix
}

#