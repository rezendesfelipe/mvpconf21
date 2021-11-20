terraform {
  backend "azurerm" {
    resource_group_name  = "rg-mvpconf21-dev-tf"
    storage_account_name = "sargmvpconf21devtf"
    container_name       = "terraform-state"
    key                  = "mvpconf2mvpconf21ch/terraform.tfstate"
    subscription_id      = "05853494-3f9a-49ed-922f-d00105861b22"
  }
}
