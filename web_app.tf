resource "azurerm_static_web_app" "web_app" {
  name                = "${var.project}-static-webapp"
  resource_group_name = azurerm_resource_group.Prod_rg.name
  location            = "West Europe"
  sku_tier            = "Standard"
  sku_size            = "Standard"

  # هنا بنربط الخانات بالمتغيرات عشان GitHub ما يزعلش
  app_settings = {
    "AAD_CLIENT_ID"         = var.aad_client_id
    "AAD_CLIENT_SECRET"     = var.aad_client_secret
    "AADB2C_CLIENT_ID"      = var.aadb2c_client_id
    "AADB2C_CLIENT_SECRET"  = var.aadb2c_client_secret
  }
}
# إنشاء الـ Public IP اللي الجيت واي محتاجه
resource "azurerm_public_ip" "appgw_ip" {
  name                = "appgw-public-ip"
  resource_group_name = azurerm_resource_group.hub_rg.name
  location            = azurerm_resource_group.hub_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# كود الـ Application Gateway مع الشهادة
resource "azurerm_application_gateway" "main_gateway" {
  name                = "${var.project}-appgw"
  resource_group_name = azurerm_resource_group.hub_rg.name
  location            = azurerm_resource_group.hub_rg.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = azurerm_subnet.App_subnet.id
  }

  frontend_port {
    name = "https_port"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "frontend_ip_config"
    public_ip_address_id = azurerm_public_ip.appgw_ip.id
  }

  ssl_certificate {
    name     = "tamim-cert"
    data     = filebase64("tamim-cert.pfx")
    password = var.cert_password
  }

  backend_address_pool {
    name  = "swa_backend"
    fqdns = [azurerm_static_web_app.web_app.default_host_name]
  }

  backend_http_settings {
    name                                = "swa_http_settings"
    cookie_based_affinity               = "Disabled"
    port                                = 443
    protocol                            = "Https"
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = "https_listener"
    frontend_ip_configuration_name = "frontend_ip_config"
    frontend_port_name             = "https_port"
    protocol                       = "Https"
    ssl_certificate_name           = "tamim-cert"
  }

  request_routing_rule {
    name                       = "swa_rule"
    rule_type                  = "Basic"
    http_listener_name         = "https_listener"
    backend_address_pool_name  = "swa_backend"
    backend_http_settings_name = "swa_http_settings"
    priority                   = 100
  }
}