terraform {
  required_version = "~> 1.0.8"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.9.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.84"
    }
  }
}