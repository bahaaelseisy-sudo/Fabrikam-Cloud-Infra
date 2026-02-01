resource "azurerm_virtual_network_peering" "from_spoke1-to-hub" {
    name = "from-spoke1-to-hub"
    resource_group_name = azurerm_resource_group.Prod_rg.name
    virtual_network_name = azurerm_virtual_network.spoke1-vnet.name
    remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
    allow_forwarded_traffic = true
    allow_virtual_network_access = true
    allow_gateway_transit = false
    use_remote_gateways = false
  
}
resource "azurerm_virtual_network_peering" "from-hub-to-spoke1" {
    name = "from-hub-to-spoke1"
    resource_group_name = azurerm_resource_group.hub_rg.name
    virtual_network_name = azurerm_virtual_network.hub_vnet.name
    remote_virtual_network_id = azurerm_virtual_network.spoke1-vnet.id
    allow_forwarded_traffic = true
    allow_virtual_network_access = true
    allow_gateway_transit = false
    use_remote_gateways = false
  
}

resource "azurerm_virtual_network_peering" "From_hub_to_spoke2" { 
    name = "From_hub_to_spoke2"
    resource_group_name = azurerm_resource_group.hub_rg.name
    virtual_network_name = azurerm_virtual_network.hub_vnet.name
    remote_virtual_network_id = azurerm_virtual_network.spoke2-vnet.id
    allow_forwarded_traffic = true
    allow_virtual_network_access = true
  allow_gateway_transit = false
  use_remote_gateways = false
}
resource "azurerm_virtual_network_peering" "from_spoke2_to_hub" {
    name = "from_spoke2_to_hub"
    resource_group_name = azurerm_resource_group.Prod_rg.name
    virtual_network_name = azurerm_virtual_network.spoke2-vnet.name
    remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
    allow_forwarded_traffic = true
    allow_virtual_network_access = true
    allow_gateway_transit = false
    use_remote_gateways = false
  
}
