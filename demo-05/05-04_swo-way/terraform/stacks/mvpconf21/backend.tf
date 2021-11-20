terraform {
  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.84"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.9.0"
    }
  }
}
