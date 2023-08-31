#Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.63"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }

  backend "azurerm" {
    resource_group_name = azurerm_resource_group.rg.name
    storage_account_name = azurerm_storage_account.tf_state.name
    container_name = azurerm_storage_container.tfstate_container.name
    key = "terraform.tfstate"
    
  }
}

#Provider Block

provider "azurerm" {
  features {}

}
