output "hdinsight_kafka_id" {
  value = azurerm_hdinsight_kafka_cluster.kafka.id
}

output "hdinsight_kafka_https_endpoint" {
  value = azurerm_hdinsight_kafka_cluster.kafka.https_endpoint
}

output "hdinsight_kafka_ssh_endpoint" {
  value = azurerm_hdinsight_kafka_cluster.kafka.ssh_endpoint
}
