terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.38.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.6.1"
    }
  }
}

provider "azurerm" {
  features {
  }

  use_cli         = true
  subscription_id = "f716a567-edba-413c-baf4-52b493c5b8f9"
}
provider "azapi" {}
