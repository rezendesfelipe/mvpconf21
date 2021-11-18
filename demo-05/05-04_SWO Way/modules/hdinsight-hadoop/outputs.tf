output "hdinsight_hadoop_id" {
  value = azurerm_hdinsight_hadoop_cluster.hadoop.id
}

output "hdinsight_hadoop_https_endpoint" {
  value = azurerm_hdinsight_hadoop_cluster.hadoop.https_endpoint
}

output "hdinsight_hadoop_ssh_endpoint" {
  value = azurerm_hdinsight_hadoop_cluster.hadoop.ssh_endpoint
}
