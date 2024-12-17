output "vm_public_ip" {
  value       = azurerm_network_interface.main_nic.ip_configuration[0].private_ip_address
  description = "The private IP address of the virtual machine"
}