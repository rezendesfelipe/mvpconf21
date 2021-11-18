resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_databricks_workspace" "dbks" {
  name                        = join("-", [var.databricks_name, random_string.random.result])
  resource_group_name         = var.resource_group_name
  managed_resource_group_name = join("-", [var.databricks_name, var.resource_group_name, random_string.random.result])
  location                    = var.location
  sku                         = var.sku

  timeouts {
    create = "30m"
  }

  dynamic "custom_parameters" {
    for_each = var.custom_param_exists == "true" ? var.custom_parameter : []
    content {
      no_public_ip        = custom_parameters.value.no_public_ip
      private_subnet_name = custom_parameters.value.private_subnet_name #"subnet-dev-mail-databricks-pri"
      public_subnet_name  = custom_parameters.value.public_subnet_name  #"subnet-dev-mail-databricks-pub"
      virtual_network_id  = custom_parameters.value.virtual_network_id  #module.vnet.vnet_id
    }
  }

  tags = var.tags

}

output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.dbks.workspace_url}/"
}
