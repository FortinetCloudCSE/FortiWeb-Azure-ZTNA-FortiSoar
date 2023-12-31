terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    fortiflexvm = {
      source  = "fortinetdev/fortiflexvm"
      version = "1.0.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    resource_group {
    prevent_deletion_if_contains_resources = false
    }
  }

  # There are multiple ways to authenticate
  # Check the provider docs to determine which
  # is the best for your environment
  # Ensure the variables are declared 

  #subscription_id = var.subscription_id
  #client_id       = var.client_id
  #client_secret   = var.client_secret
  #tenant_id       = var.tenant_id
}

provider "fortiflexvm" {
  username = var.fortiflex_api_user
  password = var.fortiflex_api_password
}