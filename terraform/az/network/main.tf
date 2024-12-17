resource "azurerm_virtual_network" "main_vnet" {
  name                = var.vpc_name
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "main_subnet" {
  name                 = "${var.vpc_name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = [var.vnet_address_space]
}
