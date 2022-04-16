terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

locals {
  is_postgres = replace(var.database_version, "POSTGRES_", "") != var.database_version

  postgres_database_flags = [
    {
      # google-sql-enable-pg-temp-file-logging
      name  = "log_temp_files"
      value = "0"
    },
    {
      # google-sql-pg-log-connections
      name  = "log_connections"
      value = "on"
    },
    {
      # google-sql-pg-log-lock-waits
      name  = "log_lock_waits"
      value = "on"
    },
    {
      # google-sql-pg-log-disconnections
      name  = "log_disconnections"
      value = "on"
    },
    {
      # google-sql-pg-log-checkpoints
      name  = "log_checkpoints"
      value = "on"
    },
  ]
  settings_backup_configuration_binary_log_enabled = local.is_postgres ? false : var.settings_backup_configuration_binary_log_enabled
  database_flags                                   = local.is_postgres ? local.postgres_database_flags : []
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
      binary_log_enabled = local.settings_backup_configuration_binary_log_enabled
    }

    ip_configuration {
      #tfsec:ignore:google-sql-encrypt-in-transit-data
      require_ssl = var.settings_ip_configuration_require_ssl

      #checkov:skip=CKV_GCP_60:Ensure Cloud SQL database does not have public IP - default value is false
      #tfsec:ignore:google-sql-no-public-access
      ipv4_enabled = var.settings_ip_configuration_ipv4_enabled

      private_network    = var.settings_ip_configuration_private_network
      allocated_ip_range = var.settings_ip_configuration_allocated_ip_range
    }

    dynamic "database_flags" {
      for_each = local.database_flags
      content {
        name  = database_flags.value.name
        value = database_flags.value.value
      }
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

    tier            = var.read_replica_settings_tier
    disk_size       = var.settings_disk_size
    disk_autoresize = var.settings_disk_autoresize
    disk_type       = var.settings_disk_type

    # Not supported for Read Replica
    availability_type = "ZONAL"

    disk_autoresize_limit = var.settings_disk_autoresize_limit

    backup_configuration {
      #tfsec:ignore:google-sql-enable-backup:read replica no need to backup
      enabled            = false
      binary_log_enabled = false
    }

    ip_configuration {
      #tfsec:ignore:google-sql-encrypt-in-transit-data:because default value is true
      require_ssl = var.settings_ip_configuration_require_ssl

      #checkov:skip=CKV_GCP_60:Ensure Cloud SQL database does not have public IP - default value is false
      #tfsec:ignore:google-sql-no-public-access
      ipv4_enabled = var.read_replica_settings_ip_configuration_ipv4_enabled

      private_network = var.settings_ip_configuration_private_network
    }

    dynamic "database_flags" {
      for_each = local.database_flags
      content {
        name  = database_flags.value.name
        value = database_flags.value.value
      }
    }
  }

  deletion_protection = var.deletion_protection
}
