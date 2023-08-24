# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  backend "azurerm" {
      resource_group_name  = "TEST-RG"
      storage_account_name = "newlookstg"
      container_name       = "tfstate"
      key                  = "test.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "CLUSTER-RG"
  location = "uksouth"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "newlook-cluster"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location  
  dns_prefix          = "newlookcluster"

  default_node_pool {
    name       = "default"
    node_count = "1"
    vm_size    = "standard_d2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}