terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.12.0"
    }
  }
}

resource "google_sql_user" "users" {
  instance = var.instance_name
  name     = var.name
  password = var.password
  type     = var.type
  host     = var.host
}
