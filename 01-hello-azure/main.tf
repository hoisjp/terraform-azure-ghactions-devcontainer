# create Azure Storage to store Terraform state
# https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.71.0"
    }
  }
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "hello-terraform-rg"
  location = var.location
}
