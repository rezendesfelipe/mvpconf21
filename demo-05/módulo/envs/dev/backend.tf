terraform {
  backend "azurerm" {
    resource_group_name  = "rg-impulse-dev-tf"
    storage_account_name = "sargimpulsedevtf"
    container_name       = "terraform-state"
    key                  = "impulse/search/terraform.tfstate"
    subscription_id      = "05853494-3f9a-49ed-922f-d00105861b22"
  }
}
