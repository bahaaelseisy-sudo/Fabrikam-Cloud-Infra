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
  address_space       = var.address_space_hub
  
   

  
  
}
resource "azurerm_virtual_network" "spoke1-vnet" {
  name = "${var.project}-spoke1-vnet"
  resource_group_name = azurerm_resource_group.Prod_rg
  location = var.location_hub
  address_space = var.vnet_spoke1_address_space
  


  
}
resource "azurerm_virtual_network" "spoke2-vnet" {
    name = "${var.project}-spoke2-vnet"
  resource_group_name = azurerm_resource_group.Test_rg
  location = var.location_spoke_paris
  address_space = var.vnet_spoke2_address_space
  
  
}
resource "azurerm_virtual_network" "onprem-vnet" {
  name = "${var.project}-onprem-vnet"
  resource_group_name = azurerm_resource_group.hub_rg
  location = var.location_hub
  address_space = var.vnet_onprem_address_space
 
  
}
resource "azurerm_subnet" "AzureFWSubnet" {
  name = "AzureFirewallSubnet"
  resource_group_name = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes = var.AzureFirewallSubnet
  
}
resource "azurerm_subnet" "App_subnet" {
  name = "app_subnet"
  resource_group_name = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.spoke1-vnet
  address_prefixes = var.APP_Subnet
  
}
resource "azurerm_subnet" "DB_subnet" {
  name = "db_subnet"
  resource_group_name = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.spoke1-vnet
  address_prefixes = var.DB_Subnet
  
}
resource "azurerm_subnet" "Identity_subnet" {
  name = "Identity_subnet"
  resource_group_name = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet
  address_prefixes = var.IdentitySubnet
  
}

