variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
  default     = "db.t2.micro"
}

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
  default     = "mydatabase"
}