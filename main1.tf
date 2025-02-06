terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "90ffa94a-3b24-47b5-aaea-d792862e8460"
}

resource "azurerm_resource_group" "bts-rg" {
  name     = "rg-bts-virchu-test-dev"
  location = "East US"
}

resource "azurerm_virtual_network" "bts-vnet" {
  name                = "vnet-bts-virchu-dev"
  location            = azurerm_resource_group.bts-rg.location
  resource_group_name = azurerm_resource_group.bts-rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "bts-subnet" {
  name                 = "subnet-bts-virchu-dev"
  resource_group_name  = azurerm_resource_group.bts-rg.name
  virtual_network_name = azurerm_virtual_network.bts-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_storage_account" "bts-storage" {
  name                     = "storagebtsvirchudev"
  resource_group_name      = azurerm_resource_group.bts-rg.name
  location                 = azurerm_resource_group.bts-rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             ="StorageV2"
  access_tier              ="Hot"
  min_tls_version          ="TLS1_2"
  allow_nested_items_to_be_public="true"
}


resource "azurerm_data_factory" "bts-adf" {
  name                = "adf-bts-virchu-dev"
  location            = azurerm_resource_group.bts-rg.location
  resource_group_name = azurerm_resource_group.bts-rg.name

  identity {
    type = "SystemAssigned"
  }
}

