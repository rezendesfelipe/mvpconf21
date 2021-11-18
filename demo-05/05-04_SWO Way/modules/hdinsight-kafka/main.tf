data "azurerm_resource_group" "kafka" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "kafka" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.kafka.name
}

data "azurerm_subnet" "kafka" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.kafka.name
  virtual_network_name = data.azurerm_virtual_network.kafka.name
}

data "azurerm_storage_account" "kafka" {
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.kafka.name
}

data "azurerm_storage_container" "kafka" {
  name                 = var.storage_account_container_name
  storage_account_name = data.azurerm_storage_account.kafka.name
}

locals {
  metastore_server_name = "sql${var.kafka_name}metastore"
}

resource "azurerm_sql_server" "metastore_server" {
  name                         = local.metastore_server_name
  resource_group_name          = data.azurerm_resource_group.kafka.name
  location                     = var.location == null ? data.azurerm_resource_group.kafka.location : var.location
  version                      = "12.0"
  administrator_login          = var.gateway_username
  administrator_login_password = var.gateway_password
}

resource "azurerm_sql_database" "metastore_database" {
  for_each                         = var.metastore_sku
  name                             = join("", ["sqldb", var.kafka_name, each.key])
  resource_group_name              = data.azurerm_resource_group.kafka.name
  location                         = var.location == null ? data.azurerm_resource_group.kafka.location : var.location
  server_name                      = azurerm_sql_server.metastore_server.name
  edition                          = "Standard"
  requested_service_objective_name = each.value
}

resource "azurerm_sql_firewall_rule" "metastore_server_rule" {
  name                = "AllowAzureServices"
  resource_group_name = data.azurerm_resource_group.kafka.name
  server_name         = azurerm_sql_server.metastore_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_hdinsight_kafka_cluster" "kafka" {
  name                = var.kafka_name
  resource_group_name = data.azurerm_resource_group.kafka.name
  location            = var.location == null ? data.azurerm_resource_group.kafka.location : var.location
  cluster_version     = var.cluster_version

  component_version {
    kafka = var.component_version_kafka
  }

  gateway {
    username = var.gateway_username
    password = var.gateway_password
  }

  roles {
    head_node {
      vm_size            = var.roles_head_node_vm_size
      username           = var.ssh_username
      password           = var.ssh_password
      subnet_id          = data.azurerm_subnet.kafka.id
      virtual_network_id = data.azurerm_virtual_network.kafka.id
    }

    worker_node {
      number_of_disks_per_node = var.roles_worker_node_number_of_disks_per_node
      vm_size                  = var.roles_worker_node_vm_size
      username                 = var.ssh_username
      password                 = var.ssh_password
      subnet_id                = data.azurerm_subnet.kafka.id
      virtual_network_id       = data.azurerm_virtual_network.kafka.id
      target_instance_count    = var.roles_worker_node_target_instance_count
    }

    zookeeper_node {
      vm_size            = var.roles_zookeeper_node_vm_size
      username           = var.ssh_username
      password           = var.ssh_password
      subnet_id          = data.azurerm_subnet.kafka.id
      virtual_network_id = data.azurerm_virtual_network.kafka.id
    }
  }

  storage_account {
    storage_container_id = data.azurerm_storage_container.kafka.id
    storage_account_key  = data.azurerm_storage_account.kafka.primary_access_key
    is_default           = var.storage_account_is_default
  }

  tier = var.tier
  tags = var.tags

  metastores {
    ambari {
      server        = join("", [local.metastore_server_name, ".database.windows.net"])
      database_name = azurerm_sql_database.metastore_database["ambari"].name
      username      = azurerm_sql_server.metastore_server.administrator_login
      password      = azurerm_sql_server.metastore_server.administrator_login_password
    }

    hive {
      server        = join("", [local.metastore_server_name, ".database.windows.net"])
      database_name = azurerm_sql_database.metastore_database["hive"].name
      username      = azurerm_sql_server.metastore_server.administrator_login
      password      = azurerm_sql_server.metastore_server.administrator_login_password
    }

    oozie {
      server        = join("", [local.metastore_server_name, ".database.windows.net"])
      database_name = azurerm_sql_database.metastore_database["oozie"].name
      username      = azurerm_sql_server.metastore_server.administrator_login
      password      = azurerm_sql_server.metastore_server.administrator_login_password
    }
  }

}
