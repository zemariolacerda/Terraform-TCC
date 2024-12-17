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

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}