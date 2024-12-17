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

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "default-vpc"
}

variable "subscription_id" {
  type = string
}
