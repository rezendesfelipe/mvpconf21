resource "azurerm_log_analytics_workspace" "analytics_works" {

  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_agent #"PerGB2018"
  retention_in_days   = var.retention_agent

}