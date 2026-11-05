terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
 
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "organization-name"

    workspaces {
      prefix = "vpc-"
    }
  }

}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}