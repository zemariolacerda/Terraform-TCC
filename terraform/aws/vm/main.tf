resource "aws_instance" "main_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "MainInstance"
  }
}