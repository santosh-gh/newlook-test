terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.48.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "TEST-RG"
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