resource "azurerm_static_web_app" "web_app" { # تم تغيير الاسم للجديد
  name                = "${var.project}-static-webapp"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  location            = "West Europe"
  sku_tier            = "Standard"
  sku_size            = "Standard"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_sql_server" "web_DB_server" {
  name                         = "sqlserver500"
  resource_group_name          = azurerm_resource_group.Prod_rg.name
  location                     = azurerm_resource_group.Prod_rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin
  administrator_login_password = var.sql_password

  # شيلنا السطر اللي كان عامل Error عشان الـ Provider قديم
}

resource "azurerm_sql_database" "App_DB" {
  name                = "${var.project}-db"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  location            = azurerm_resource_group.Prod_rg.location
  server_name         = azurerm_sql_server.web_DB_server.name
  edition             = "Basic"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
}

# الـ Private Endpoint بتاعك زي ما هو
resource "azurerm_private_endpoint" "Sql-ep" {
  name                = "${var.project}-sql-ep"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  location            = azurerm_resource_group.Prod_rg.location
  subnet_id           = azurerm_subnet.DB_subnet.id

  private_service_connection {
    name                           = "${var.project}-sql-privlink"
    private_connection_resource_id = azurerm_sql_server.web_DB_server.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }
}

# قاعدة الـ Firewall اللي هتسمح للـ SWA بالدخول
resource "azurerm_sql_firewall_rule" "allow_azure_services" {
  name                = "AllowAzureServices"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  server_name         = azurerm_sql_server.web_DB_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}