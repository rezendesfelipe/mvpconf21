data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_data_factory" "df" {
  name                = var.df_name
  location            = var.location
  resource_group_name = var.resource_group_name
}
