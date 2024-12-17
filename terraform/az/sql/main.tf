resource "azurerm_resource_group" "main_rg" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_mysql_server" "example" {
  name                = "${sql_server_name}-server"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  administrator_login          = "mysqladminun"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = var.sku_name
}

resource "azurerm_mysql_database" "example" {
  name                = "${sql_server_name}-database"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_server.example.name
}