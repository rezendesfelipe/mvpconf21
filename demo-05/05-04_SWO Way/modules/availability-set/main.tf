data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_availability_set" "as" {
  name                         = var.as_name
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = var.location == null ? data.azurerm_resource_group.rg.location : var.location
  platform_update_domain_count = var.update_domain_count
  platform_fault_domain_count  = var.fault_domain_count
  tags                         = var.tags
}
