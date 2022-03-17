terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0.0"
    }
  }
}

resource "google_sql_database_instance" "instance" {
  database_version = var.database_version

  name   = var.name
  region = var.region

  master_instance_name = var.master_instance_name

  settings {

    tier              = var.settings_tier
    disk_size         = var.settings_disk_size
    disk_type         = var.settings_disk_type
    availability_type = var.settings_availability_type

    backup_configuration {
      enabled            = var.settings_backup_configuration_enabled
      binary_log_enabled = var.settings_backup_configuration_binary_log_enabled
    }

    ip_configuration {
      require_ssl = var.settings_ip_configuration_require_ssl

      #checkov:skip=CKV_GCP_60:Ensure Cloud SQL database does not have public IP - default value is false
      ipv4_enabled = var.settings_ip_configuration_ipv4_enabled

      private_network = var.settings_ip_configuration_private_network
    }
  }

  deletion_protection = var.deletion_protection
}
