resource "azurerm_network_interface" "DC_Nic" {
  name = "DC_Nic"
  resource_group_name = azurerm_resource_group.hub_rg.name
  location = azurerm_resource_group.hub_rg.location
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.Identity_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  
}
resource "azurerm_windows_virtual_machine" "DC-VM" {
  name                = "DC-VM"
  resource_group_name = azurerm_resource_group.hub_rg
  location            = azurerm_resource_group.hub_rg.location
  size                = "Standard_B2s"
  admin_username      = "testadmin"
  admin_password      = "Password1234!"
  network_interface_ids = [
    azurerm_network_interface.DC_Nic.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
