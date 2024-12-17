resource "google_sql_database_instance" "main_instance" {
  name             = var.db_instance_name
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }

  root_password = "password"
}

resource "google_sql_database" "main_db" {
  name     = var.db_name
  instance = google_sql_database_instance.main_instance.name
}