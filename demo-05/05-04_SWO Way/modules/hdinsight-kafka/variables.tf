variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group a ser utilizado"
}

variable "location" {
  type        = string
  description = "Localização do recurso."
  default     = null
}

variable "vnet_name" {
  type        = string
  description = "Nome da Vnet"
}

variable "subnet_name" {
  type        = string
  description = "Nome da Subnet"
}

variable "storage_account_name" {
  type        = string
  description = "Nome da Storage Account"
}

variable "storage_account_container_name" {
  type        = string
  description = "Nome do container da Storage Account"
}

variable "kafka_name" {
  type        = string
  description = "Nome do cluster Kafka no HDInsight"
}

variable "cluster_version" {
  type        = string
  description = "Versão do cluster"
}

variable "component_version_kafka" {
  type        = string
  description = "Versão do Kafka que será utilizada no cluster do HDInsight Kafka"
}

variable "gateway_username" {
  type        = string
  description = "Usuário usado para o portal do Ambari e acesso ao SQL Server."
}

variable "gateway_password" {
  type        = string
  description = "Senha utilizada para o usuário que irá acessar o portal do Ambari e SQL Server. Esta senha deve ser diferente da usada para as funções head_node, worker_node e zookeeper_node."
  sensitive   = true
}

variable "ssh_username" {
  type        = string
  description = "Usuário utilizado para conectar-se no cluster via ssh"
  default     = "sshuser"
}

variable "ssh_password" {
  type        = string
  description = "Senha utilizada para conectar-se no cluster via ssh"
  sensitive   = true
}

variable "roles_head_node_vm_size" {
  type        = string
  description = "Tamanho da máquina virtual que deve ser usado para os head nodes"
}

variable "roles_worker_node_number_of_disks_per_node" {
  type        = string
  description = "Número de discos de dados que devem ser atribuídos a cada nó de trabalho. Pode ser entre 1 e 8"
}

variable "roles_worker_node_vm_size" {
  type        = string
  description = "Tamanho da máquina virtual que deve ser usado para os worker nodes"
}

variable "roles_worker_node_target_instance_count" {
  type        = number
  description = "Número de instâncias que devem rodar como worker nodes"
}

variable "roles_zookeeper_node_vm_size" {
  type        = string
  description = "Tamanho da máquina virtual que deve ser usado para os zookeeper nodes"
}

variable "storage_account_is_default" {
  type        = bool
  description = "Informa se esta será a storage account padrão para o HDInsigth"
  default     = true
}

variable "tier" {
  type        = string
  description = "Especifica a camada que deve ser usada para o cluster HDInsight Kafka. Os valores possíveis são Standard ou Premium"
}

variable "tags" {
  type        = map(any)
  description = "Tags a serem aplicadas no HDInsight"
  default     = {}
}

variable "metastore_sku" {
  type        = map(any)
  description = "SKUs dos databases a serem utilizados como metastore."
  default = {
    ambari = "S0"
    hive   = "S0"
    oozie  = "S0"
  }
}
