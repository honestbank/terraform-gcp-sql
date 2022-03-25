terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.0.0"
    }
  }
}

provider "google" {
  project     = var.google_project
  region      = var.google_region
  credentials = var.google_credentials
}

provider "google-beta" {
  project     = var.google_project
  region      = var.google_region
  credentials = var.google_credentials
}

resource "random_id" "instance_suffix" {
  byte_length = 4
}


resource "google_sql_database_instance" "main" {
  provider = google-beta

  name             = "main-instance-${random_id.instance_suffix.hex}"
  database_version = "MYSQL_8_0"
  region           = var.google_region
  project          = var.google_project

  deletion_protection = false

  settings {
    tier = "db-f1-micro"

    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }

    ip_configuration {
      require_ssl = true

      #checkov:skip=CKV_GCP_60:Ensure Cloud SQL database does not have public IP - default value is false
      ipv4_enabled = true
    }
  }
}
