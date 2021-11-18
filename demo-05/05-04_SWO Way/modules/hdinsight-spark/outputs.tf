output "hdinsight_spark_id" {
  value = azurerm_hdinsight_spark_cluster.spark.id
}

output "hdinsight_spark_https_endpoint" {
  value = azurerm_hdinsight_spark_cluster.spark.https_endpoint
}

output "hdinsight_spark_ssh_endpoint" {
  value = azurerm_hdinsight_spark_cluster.spark.ssh_endpoint
}
