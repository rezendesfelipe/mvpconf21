data "azurerm_resource_group" "func" {
  name = var.resource_group_name
}

resource "azurerm_app_service_plan" "azure-func-plan" {
  name                = lower(join("-", ["fnc", var.vertical, var.produto, "plan", var.ambiente]))
  location            = var.location == null ? data.azurerm_resource_group.func.location : var.location
  resource_group_name = data.azurerm_resource_group.func.name
  kind                = var.func_kind
  tags                = var.tags_apps
  sku {
    tier = var.func_plan_sku_tier
    size = var.func_plan_sku_size
  }
}

resource "azurerm_function_app" "func_apps" {
  for_each = var.func_apps

  name                       = lower(join("-", [each.key, "func"]))
  resource_group_name        = data.azurerm_resource_group.func.name
  location                   = var.location == null ? data.azurerm_resource_group.func.location : var.location
  app_service_plan_id        = azurerm_app_service_plan.azure-func-plan.id
  storage_account_name       = each.value["storage_name"]
  storage_account_access_key = each.value["storage_primary_access_key"]
  tags                       = var.tags_apps



  depends_on = [azurerm_app_service_plan.azure-func-plan]
}
