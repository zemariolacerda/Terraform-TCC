variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "AMI ID to use for the instance"
  type        = string
  default     = "ami-12345678"  # Replace with a valid AMI ID
}