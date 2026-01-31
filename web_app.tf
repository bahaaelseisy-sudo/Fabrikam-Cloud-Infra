resource "azurerm_service_plan" "app_plan" {
    name = "${var.project}-plan"
  resource_group_name = azurerm_resource_group.Prod_rg
  location = azurerm_resource_group.Prod_rg.location
  sku_name = "F1"
  os_type = "Linux"

}

resource "azurerm_linux_web_app" "web_app" {
    name = "${var.project}-webapp"
  resource_group_name = azurerm_resource_group.Prod_rg
  location = azurerm_resource_group.Prod_rg.location
  service_plan_id = azurerm_service_plan.app_plan.id

  site_config {

  }
  identity {type = "SystemAssigned"}
}

  
resource azurerm_sql_server"web_DB_server" {
    name = "${var.project}-sqlserver"
  resource_group_name = azurerm_resource_group.Prod_rg
  location = azurerm_resource_group.Prod_rg.location
  version = "12.0"
  administrator_login = var.sql_admin
  administrator_login_password = var.sql_password
  
}
resource "azurerm_sql_database" "App_DB" {
    name = "${var.project}-db"
  resource_group_name = azurerm_resource_group.Prod_rg
  location = azurerm_resource_group.Prod_rg.location
  server_name = azurerm_sql_server.web_DB_server.name
  edition = "Basic"
  collation = "SQL_Latin1_General_CP1_CI_AS"
  max_size_bytes = 52428800
  
}
resource "azurerm_private_endpoint" "Sql-ep" {
    name = "${var.project}-sql-ep"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  location = azurerm_resource_group.Prod_rg.location
  subnet_id = azurerm_subnet.DB_subnet

    private_service_connection {
    name = "${var.project}-sql-privlink"
    private_connection_resource_id = azurerm_sql_server.web_DB_server.id
    is_manual_connection = false
    subresource_names = ["sqlServer"]
  }
  
}
