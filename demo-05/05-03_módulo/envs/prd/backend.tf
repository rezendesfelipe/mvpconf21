terraform {
  backend "azurerm" {
    resource_group_name  = "rg-mvpconf21-prd-tf"
    storage_account_name = "sargmvpconf21prdtf"
    container_name       = "terraform-state"
    key                  = "mvpconf21/terraform.tfstate"
    subscription_id      = "50d52bc3-6efa-4846-ab98-20f2213"
  }
}