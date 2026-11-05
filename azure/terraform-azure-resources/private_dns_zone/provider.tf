terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.18.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "prismpay"

    workspaces {
      prefix = "private_dns_zone-"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}