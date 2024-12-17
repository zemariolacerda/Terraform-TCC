output "vpc_id" {
  description = "The ID of the VPC created"
  value       = aws_vpc.main_vpc.id
}

output "subnet_id" {
  description = "The ID of the subnet created"
  value       = aws_subnet.main_subnet.id
}