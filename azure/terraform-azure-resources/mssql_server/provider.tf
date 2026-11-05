terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.18.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "organization-name"

    workspaces {
      prefix = "mssql_server-"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}