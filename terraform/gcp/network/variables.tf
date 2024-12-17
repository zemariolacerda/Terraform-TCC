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

variable "vpc_network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "default-vpc"
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}