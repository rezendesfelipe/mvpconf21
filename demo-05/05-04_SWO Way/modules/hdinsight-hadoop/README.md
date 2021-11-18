# Módulo de HDInsight Hadoop
## Variáveis válidas
Este módulo aceita as seguintes variáveis:

* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.

* [Obrigatório] `vnet_name`: Nome da Vnet.

* [Obrigatório] `subnet_name`: Nome da Subnet.

* [Obrigatório] `storage_account_name`: Nome da Storage Account.

* [Obrigatório] `storage_account_container_name`: Nome do container da Storage Account.

* [Obrigatório] `hadoop_name`: Nome do cluster Hadoop no HDInsight.

* [Obrigatório] `cluster_version`: Versão do cluster.

* [Obrigatório] `component_version_hadoop`: Versão do Hadoop que será utilizada no cluster do HDInsight Hadoop.

* [Obrigatório] `gateway_username`: Usuário usado para o portal do Ambari e acesso ao SQL Server.

* [Obrigatório] `gateway_password`: Senha utilizada para o usuário que irá acessar o portal do Ambari e SQL Server. Esta senha deve ser diferente da usada para as funções head_node, worker_node e zookeeper_node.

* [Obrigatório] `ssh_password`: Senha utilizada para conectar-se no cluster via ssh.

* [Obrigatório] `roles_head_node_vm_size`: Tamanho da máquina virtual que deve ser usado para os head nodes.

* [Obrigatório] `roles_worker_node_vm_size`: Tamanho da máquina virtual que deve ser usado para os worker nodes.

* [Obrigatório] `roles_worker_node_target_instance_count`: Número de instâncias que devem rodar como worker nodes.

* [Obrigatório] `roles_zookeeper_node_vm_size`: Tamanho da máquina virtual que deve ser usado para os zookeeper nodes.

* [Obrigatório] `roles_zookeeper_node_username`: Usuário administrador para os zookeeper nodes.

* [Obrigatório] `tier`: Especifica a camada que deve ser usada para o cluster HDInsight Hadoop. Os valores possíveis são Standard ou Premium.

* [Opcional] `location`: Localização do recurso.

* [Opcional] `ssh_username`: Usuário utilizado para conectar-se no cluster via ssh.

* [Opcional] `storage_account_is_default`: Informa se esta será a storage account padrão para o HDInsigth.

* [Opcional] `tags`: Tags a serem aplicadas no HDInsight.

* [Opcional] `metastore_sku`: SKUs dos databases a serem utilizados como metastore.

## Ouputs gerados pelo módulo
* `hdinsight_hadoop_id`: id do cluster HDInsight Hadoop
* `hdinsight_hadoop_https_endpoint`: O endpoint HTTPS do cluster HDInsight Hadoop.
* `hdinsight_hadoop_ssh_endpoint`: O endpoint SSH do cluster HDInsight Hadoop.

## Casos de uso
### Exemplo de código
Terraform 0.14.x
``` Go
module "hadoop" {
  source                                  = "../../../modules/hdinsight-hadoop"
  resource_group_name                     = modules.rg.rg_name
  vnet_name                               = modules.vnet.vnet_name
  subnet_name                             = modules.vnet.vnet_subnet_names[5]
  storage_account_name                    = "stgimpulseplatform01"
  storage_account_container_name          = "raw-hadoop"
  hadoop_name                             = "hadoop-impulse-platform"  
  cluster_version                         = "3.6"
  component_version_hadoop                = "2.7"
  gateway_username                        = "adminuser"
  gateway_password                        = "P2ssw0rd@123"
  ssh_username                            = "sshuser"
  ssh_password                            = "P2ssw0rd@123"
  roles_head_node_vm_size                 = "A5"
  roles_worker_node_vm_size               = "A5"
  roles_worker_node_target_instance_count = 2
  roles_zookeeper_node_vm_size            = "Small"
  tier                                    = "Standard"

  tags = {
    Ambiente      = "Desenvolvimento"
    Departamento  = "Platform"
    Centro_Custo  = 12345
  }

  depends_on      = [modules.rg, modules.vnet, modules.storage-account, modules.storage-container]
}
```
### Exemplo de plan
<details><summary>Expanda para ver o exemplo</summary>

``` Go
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.hadoop.azurerm_hdinsight_hadoop_cluster.hadoop will be created
  + resource "azurerm_hdinsight_hadoop_cluster" "hadoop" {
      + cluster_version     = "3.6"
      + https_endpoint      = (known after apply)
      + id                  = (known after apply)
      + location            = "eastus"
      + name                = "hadoop-impulse-platform"
      + resource_group_name = "rg-terraform"
      + ssh_endpoint        = (known after apply)
      + tags                = {
          + "Ambiente"     = "Desenvolvimento"
          + "Centro_Custo" = "12345"
          + "Departamento" = "Platform"
        }
      + tier                = "Standard"

      + component_version {
          + hadoop = "2.7"
        }

      + gateway {
          + enabled  = true
          + password = (sensitive value)
          + username = "adminuser"
        }

      + roles {
          + head_node {
              + password           = (sensitive value)
              + subnet_id          = "/subscriptions/4599b056-ba27-4284-9a04-637b49f73370/resourceGroups/rg-terraform/providers/Microsoft.Network/virtualNetworks/vnet-terraform/subnets/default"
              + username           = "sshuser"
              + virtual_network_id = "/subscriptions/4599b056-ba27-4284-9a04-637b49f73370/resourceGroups/rg-terraform/providers/Microsoft.Network/virtualNetworks/vnet-terraform"
              + vm_size            = "A5"
            }

          + worker_node {
              + min_instance_count    = (known after apply)
              + password              = (sensitive value)
              + subnet_id             = "/subscriptions/4599b056-ba27-4284-9a04-637b49f73370/resourceGroups/rg-terraform/providers/Microsoft.Network/virtualNetworks/vnet-terraform/subnets/default"
              + target_instance_count = 2
              + username              = "sshuser"
              + virtual_network_id    = "/subscriptions/4599b056-ba27-4284-9a04-637b49f73370/resourceGroups/rg-terraform/providers/Microsoft.Network/virtualNetworks/vnet-terraform"
              + vm_size               = "A5"
            }

          + zookeeper_node {
              + password           = (sensitive value)
              + subnet_id          = "/subscriptions/4599b056-ba27-4284-9a04-637b49f73370/resourceGroups/rg-terraform/providers/Microsoft.Network/virtualNetworks/vnet-terraform/subnets/default"
              + username           = "sshuser"
              + virtual_network_id = "/subscriptions/4599b056-ba27-4284-9a04-637b49f73370/resourceGroups/rg-terraform/providers/Microsoft.Network/virtualNetworks/vnet-terraform"
              + vm_size            = "Small"
            }
        }

      + storage_account {
          + is_default           = true
          + storage_account_key  = (sensitive value)
          + storage_container_id = "https://stgimpulseplatform01.blob.core.windows.net/raw-hadoop"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + hdinsight_hadoop_id             = (known after apply)
  + hdinsight_hadoop_https_endpoint = (known after apply)
  + hdinsight_hadoop_ssh_endpoint   = (known after apply)
```
</details>

<br/>

Clique [**aqui**](../../README.md) para voltar para a página principal da documentação.
