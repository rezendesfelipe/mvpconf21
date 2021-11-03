terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform"
    storage_account_name = "sargterraformdev"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
    subscription_id      = "00000000-0000-0000-0000-000000000000"
    client_id            = "00000000-0000-0000-0000-000000000000"
    client_secret        = "abc123"
    tenant_id            = "00000000-0000-0000-0000-000000000000"
  }
}
