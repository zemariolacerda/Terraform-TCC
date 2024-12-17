output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.main_instance.public_ip
}