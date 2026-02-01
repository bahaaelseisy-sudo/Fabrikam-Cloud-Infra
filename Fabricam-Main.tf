resource "azurerm_resource_group" "hub_rg" {
  name = "${var.project}-hub-rg"
  location = var.location_hub
  
}
resource "azurerm_resource_group" "Prod_rg" {
  name = "${var.project}-prod-rg"
  location = var.location_hub
  
}
resource "azurerm_resource_group" "Test_rg" {
  name = "${var.project}-test-rg"
  location = var.location_hub
  tags = {
    Environment = "Test"
  }
  
}
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "${var.project}-hub-vnet"
  resource_group_name = azurerm_resource_group.hub_rg.name
  location            = azurerm_resource_group.hub_rg.location
  address_space = ["10.0.0.0/16"]
  
   

  
  
}
resource "azurerm_virtual_network" "spoke1-vnet" {
  name = "${var.project}-spoke1-vnet"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  location = var.location_hub
  address_space = ["10.1.0.0/16"]
  


  
}
resource "azurerm_virtual_network" "spoke2-vnet" {
    name = "${var.project}-spoke2-vnet"
  resource_group_name = azurerm_resource_group.Test_rg.name
  location = var.location_spoke_paris
  address_space = ["10.2.0.0/16"]
  
  
}
resource "azurerm_virtual_network" "onprem-vnet" {
  name = "${var.project}-onprem-vnet"
  resource_group_name = azurerm_resource_group.hub_rg.name
  location = var.location_hub
  address_space = ["10.3.0.0/16"]
 
  
}
resource "azurerm_subnet" "AzureFWSubnet" {
  name = "AzureFirewallSubnet"
  resource_group_name = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes = ["10.0.1.0/26"]
  
}
resource "azurerm_subnet" "App_subnet" {
  name = "app_subnet"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  virtual_network_name = azurerm_virtual_network.spoke1-vnet.name
  address_prefixes = ["10.1.1.0/24"]
  
}
resource "azurerm_subnet" "DB_subnet" {
  name = "db_subnet"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  virtual_network_name = azurerm_virtual_network.spoke1-vnet.name
  address_prefixes = ["10.1.2.0/24"]
  
}
resource "azurerm_subnet" "Identity_subnet" {
  name = "Identity_subnet"
  resource_group_name = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes = ["10.3.1.0/24"]
  
}

