output "sql_server_fqdn" {
  description = "The fully qualified domain name of the SQL server"
  value       = azurerm_sql_server.main_sql_server.fully_qualified_domain_name
}