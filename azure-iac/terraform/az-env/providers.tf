terraform {
  backend "azurerm" {

  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.17.0"
    }
  }
}

provider "azurerm" {
  features {}
}