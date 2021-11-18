data "azurerm_resource_group" "spark" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "spark" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "spark" {
  name                 = var.subnet_name
  resource_group_name  = var.vnet_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.spark.name
}

resource "random_string" "random" {
  length  = 4
  special = false
  number  = false
}

resource "azurerm_storage_account" "stg" {
  name                     = lower(join("", [var.storage_account_name, random_string.random.result]))
  resource_group_name      = data.azurerm_resource_group.spark.name
  location                 = var.location == null ? data.azurerm_resource_group.spark.location : var.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "GRS"
  tags                     = var.tags
}

resource "azurerm_storage_container" "container" {
  name                 = var.storage_account_container_name
  storage_account_name = azurerm_storage_account.stg.name
}

locals {
  metastore_server_name = "sql-${var.spark_name}-metastore"
  fixed_cluster_name    = replace(var.spark_name, "-", "")
}

resource "azurerm_sql_server" "metastore_server" {
  name                         = local.metastore_server_name
  resource_group_name          = data.azurerm_resource_group.spark.name
  location                     = var.location == null ? data.azurerm_resource_group.spark.location : var.location
  version                      = "12.0"
  administrator_login          = var.gateway_username
  administrator_login_password = var.gateway_password
}

resource "azurerm_sql_database" "metastore_database" {
  for_each                         = var.metastore_sku
  name                             = join("", ["sqldb", local.fixed_cluster_name, each.key])
  resource_group_name              = data.azurerm_resource_group.spark.name
  location                         = var.location == null ? data.azurerm_resource_group.spark.location : var.location
  server_name                      = azurerm_sql_server.metastore_server.name
  edition                          = "Standard"
  requested_service_objective_name = each.value
}

resource "azurerm_sql_firewall_rule" "metastore_server_rule" {
  name                = "AllowAzureServices"
  resource_group_name = data.azurerm_resource_group.spark.name
  server_name         = azurerm_sql_server.metastore_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_hdinsight_spark_cluster" "spark" {
  name                = var.spark_name
  resource_group_name = data.azurerm_resource_group.spark.name
  location            = var.location == null ? data.azurerm_resource_group.spark.location : var.location
  cluster_version     = var.cluster_version

  component_version {
    spark = var.component_version_spark
  }

  gateway {
    username = var.gateway_username
    password = var.gateway_password
  }

  roles {
    head_node {
      vm_size            = var.roles_head_node_vm_size
      username           = var.ssh_username
      ssh_keys           = [var.ssh_key]
      subnet_id          = data.azurerm_subnet.spark.id
      virtual_network_id = data.azurerm_virtual_network.spark.id
    }

    worker_node {
      vm_size               = var.roles_worker_node_vm_size
      username              = var.ssh_username
      ssh_keys              = [var.ssh_key]
      subnet_id             = data.azurerm_subnet.spark.id
      virtual_network_id    = data.azurerm_virtual_network.spark.id
      target_instance_count = var.roles_worker_node_target_instance_count
      autoscale {
        recurrence {
          timezone = "E. South America Standard Time"
          dynamic "schedule" {
            for_each = var.autoscale_schedules
            content {
              days                  = schedule.value.days
              time                  = schedule.value.time
              target_instance_count = schedule.value.target_instance_count
            }
          }
        }
      }
    }

    zookeeper_node {
      vm_size            = var.roles_zookeeper_node_vm_size
      username           = var.ssh_username
      ssh_keys           = [var.ssh_key]
      subnet_id          = data.azurerm_subnet.spark.id
      virtual_network_id = data.azurerm_virtual_network.spark.id
    }
  }

  storage_account {
    storage_container_id = azurerm_storage_container.container.id
    storage_account_key  = azurerm_storage_account.stg.primary_access_key
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
