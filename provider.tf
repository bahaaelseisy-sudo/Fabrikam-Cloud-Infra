terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "Terraform-Management-RG"
    storage_account_name = "fabtfstate2026"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate" # اسم الملف اللي هيظهر جوه الكونتينر
  }
}

provider "azurerm" {
  features {}
}
