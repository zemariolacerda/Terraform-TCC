output "vnet_id" {
  value       = azurerm_virtual_network.main_vnet.id
  description = "The ID of the Virtual Network created"
}

output "subnet_id" {
  value       = azurerm_subnet.main_subnet.id
  description = "The ID of the subnet created"
}
