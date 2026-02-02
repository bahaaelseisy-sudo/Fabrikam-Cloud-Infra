resource "azurerm_static_site" "web_app" {
  name                = "${var.project}-static-webapp"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  location            = "West Europe" # الـ Static Web App متاح في مناطق محددة (West Europe هي الأقرب لـ North Europe)
  sku_tier            = "Free"
  sku_size            = "Free"
}


  
resource azurerm_sql_server"web_DB_server" {
    name = "sqlserver500"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  location = azurerm_resource_group.Prod_rg.location
  version = "12.0"
  administrator_login = var.sql_admin
  administrator_login_password = var.sql_password
  
}
resource "azurerm_sql_database" "App_DB" {
    name = "${var.project}-db"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  location = azurerm_resource_group.Prod_rg.location
  server_name = azurerm_sql_server.web_DB_server.name
  edition = "Basic"
  collation = "SQL_Latin1_General_CP1_CI_AS"
  
  
}
resource "azurerm_private_endpoint" "Sql-ep" {
    name = "${var.project}-sql-ep"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  location = azurerm_resource_group.Prod_rg.location
  subnet_id = azurerm_subnet.DB_subnet.id

    private_service_connection {
    name = "${var.project}-sql-privlink"
    private_connection_resource_id = azurerm_sql_server.web_DB_server.id
    is_manual_connection = false
    subresource_names = ["sqlServer"]
  }
  
}
