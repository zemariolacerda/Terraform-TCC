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

variable "db_instance_name" {
  description = "The name of the Cloud SQL instance"
  type        = string
  default     = "my-sql-instance"
}

variable "db_name" {
  description = "The name of the SQL database"
  type        = string
  default     = "mydatabase"
}

variable "tier" {
  description = "SQL database tier"
  type        = string
  default     = "db-f1-micro"
}

