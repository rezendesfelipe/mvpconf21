terraform {
  required_providers {
    azurerm = {
      source   = "hashicorp/azurerm"
      version  = "~> 2.84"
    }
  }
}

provider "azurerm" {
  features {}
}