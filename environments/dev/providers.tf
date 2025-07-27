terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.21.1"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
  #subscription_id = var.subscription_id
  subscription_id = "ea891df5-f65a-40c0-9880-4eae51df72de"
}

# variable "subscription_id" {
#   description = "The Azure Subscription ID."
#   type        = string
# }

# provider "azuread" {
# }