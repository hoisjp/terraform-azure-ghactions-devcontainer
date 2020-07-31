# create Azure Storage to store Terraform state
# https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

terraform {
  backend "azurerm" {
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "hello-terraform-rg"
  location = var.location
}
