variable "project" {
  description = "The GCP project to use"
  type        = string
  default     = "my-gcp-project"
}

variable "region" {
  description = "The GCP region to create resources in"
  type        = string
  default     = "us-central1"
}

variable "machine_type" {
  description = "The type of machine to create"
  type        = string
  default     = "e2-micro"
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "main-network"
}