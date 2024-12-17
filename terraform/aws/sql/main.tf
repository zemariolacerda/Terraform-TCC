resource "aws_db_instance" "main_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.db_instance_class
  db_name                 = var.db_name
  username             = "admin"
  password             = "password"
}