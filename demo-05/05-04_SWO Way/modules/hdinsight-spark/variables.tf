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

variable "spark_name" {
  type        = string
  description = "Nome do cluster Spark no HDInsight"
}

variable "cluster_version" {
  type        = string
  description = "Versão do cluster"
}

variable "component_version_spark" {
  type        = string
  description = "Versão do Spark que será utilizada no cluster do HDInsight Spark"
}

variable "gateway_username" {
  type        = string
  description = "Usuário usado para o portal do Ambari e acesso ao SQL Server"
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

variable "ssh_key" {
  type        = string
  description = "Chave pública para conectar-se ao cluster via ssh"
}

variable "roles_head_node_vm_size" {
  type        = string
  description = "Tamanho da máquina virtual que deve ser usado para os head nodes"
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
  description = "Especifica a camada que deve ser usada para o cluster HDInsight Spark. Os valores possíveis são Standard ou Premium"
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

variable "vnet_resource_group_name" {
  type = string
}

variable "autoscale_schedules" {
  type = list(object({
    days                  = list(string)
    time                  = string
    target_instance_count = number
  }))
}
