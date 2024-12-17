resource "azurerm_resource_group" "main_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "main_vnet" {
  name                = "mainVNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
}

resource "azurerm_subnet" "main_subnet" {
  name                 = "mainSubnet"
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "main_nic" {
  name                = "mainNIC"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  ip_configuration {
    name                          = "mainIPConfig"
    subnet_id                     = azurerm_subnet.main_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "main_vm" {
  name                = "mainVM"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = azurerm_resource_group.main_rg.location
  size                = var.vm_size
  network_interface_ids = [azurerm_network_interface.main_nic.id]
  admin_username      = "azureuser"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}