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

    tier                  = var.settings_tier
    disk_size             = var.settings_disk_size
    disk_autoresize       = var.settings_disk_autoresize
    disk_type             = var.settings_disk_type
    availability_type     = var.settings_availability_type
    disk_autoresize_limit = var.settings_disk_autoresize_limit

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

locals {
  instance_read_replica = var.name != "" ? "${var.name}-read-replica" : ""
}

resource "google_sql_database_instance" "read_replica" {
  depends_on = [
    google_sql_database_instance.instance
  ]

  count = var.enable_read_replica ? 1 : 0

  database_version = var.database_version

  name   = local.instance_read_replica
  region = var.region

  master_instance_name = google_sql_database_instance.instance.name

  settings {

    tier                  = var.read_replica_settings_tier
    disk_size             = var.settings_disk_size
    disk_autoresize       = var.settings_disk_autoresize
    disk_type             = var.settings_disk_type
    availability_type     = var.settings_availability_type
    disk_autoresize_limit = var.settings_disk_autoresize_limit

    backup_configuration {
      enabled            = false
      binary_log_enabled = false
    }

    ip_configuration {
      require_ssl = var.settings_ip_configuration_require_ssl

      #checkov:skip=CKV_GCP_60:Ensure Cloud SQL database does not have public IP - default value is false
      ipv4_enabled = var.read_replica_settings_ip_configuration_ipv4_enabled

      private_network = var.settings_ip_configuration_private_network
    }
  }

  deletion_protection = var.deletion_protection
}
