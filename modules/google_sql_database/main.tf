terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.12.0"
    }
  }
}

resource "google_sql_database" "database" {
  name     = var.name
  instance = var.instance_name

  charset   = var.charset
  collation = var.collation
}
