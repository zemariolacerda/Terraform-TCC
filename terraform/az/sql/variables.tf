variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "TerraformResourceGroup"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
  default     = "my-sql-server"
}

variable "db_name" {
  description = "The name of the SQL Database"
  type        = string
  default     = "mydatabase"
}

variable "sku_name" {
  description = "Database sku"
  type        = string
  default     = "B_Gen5_2"
}