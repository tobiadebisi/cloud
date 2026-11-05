terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.18.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "prismpay"

    workspaces {
      prefix = "aks-"
    }
  }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}