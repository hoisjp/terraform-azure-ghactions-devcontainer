# create Azure Storage to store Terraform state
# https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.71.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "terraform-rg"
  location = var.location
}

resource "azurerm_storage_account" "strg" {
  name                     = var.backend_storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "strg-container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.strg.name
  container_access_type = "private"
}