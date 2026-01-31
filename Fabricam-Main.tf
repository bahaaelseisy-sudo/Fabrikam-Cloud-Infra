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
  subnet {
    name = "AzureFirewallSubnet"
    address_prefixes = var.AzureFirewallSubnet
  }
   

  
  
}
resource "azurerm_virtual_network" "spoke1-vnet" {
  name = "${var.project}-spoke1-vnet"
  resource_group_name = azurerm_resource_group.Prod_rg
  location = var.location_hub
  address_space = var.vnet_spoke1_address_space
  subnet{
    
    name = "App_Subnet"
    address_prefixes = var.APP_Subnet

  }
  
  subnet{
    
    name = "DB_Subnet"
    address_prefixes = var.DB_Subnet

  }



  
}
resource "azurerm_virtual_network" "spoke2-vnet" {
    name = "${var.project}-spoke2-vnet"
  resource_group_name = azurerm_resource_group.Test_rg
  location = var.location_spoke_paris
  address_space = var.vnet_spoke2_address_space
  subnet{
    name = "Spoke2-APP"
    address_prefixes = var.vnet_spoke2_app_subnet

  }

  subnet{
    name = "Spoke2-DB"
    address_prefixes = var.vnet_spoke2_db_subnet
  
  }
  
}
resource "azurerm_virtual_network" "onprem-vnet" {
  name = "${var.project}-onprem-vnet"
  resource_group_name = azurerm_resource_group.hub_rg
  location = var.location_hub
  address_space = var.vnet_onprem_address_space
  subnet {
    name = "Identity_Subnet"
    address_prefixes = var.IdentitySubnet
  }
  
}
