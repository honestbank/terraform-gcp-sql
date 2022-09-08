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

  mysql_database_flags = {
    # enable Cloud SQL for MySQL Audit Plugin - https://cloud.google.com/sql/docs/mysql/use-db-audit#audit_plugin_settings
    cloudsql_mysql_audit = "ON"
  }

  postgres_database_flags = {
    # google-sql-enable-pg-temp-file-logging
    log_temp_files = "0"
    # google-sql-pg-log-connections
    log_connections = "on"
    # google-sql-pg-log-lock-waits
    log_lock_waits = "on"
    # google-sql-pg-log-disconnections
    log_disconnections = "on"
    # google-sql-pg-log-checkpoints
    log_checkpoints = "on"
  }

  settings_backup_configuration_binary_log_enabled             = local.is_postgres ? false : var.settings_backup_configuration_binary_log_enabled
  settings_backup_configuration_point_in_time_recovery_enabled = local.is_postgres ? var.settings_backup_configuration_point_in_time_recovery_enabled : false

  tmp_database_flags    = local.is_postgres ? local.postgres_database_flags : local.mysql_database_flags
  custom_database_flags = merge(var.settings_database_flags, local.tmp_database_flags)
}

#These setting will override from code
#tfsec:ignore:google-sql-enable-pg-temp-file-logging tfsec:ignore:google-sql-pg-log-connections tfsec:ignore:google-sql-pg-log-lock-waits tfsec:ignore:google-sql-pg-log-disconnections tfsec:ignore:google-sql-pg-log-checkpoints
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

      start_time                     = var.settings_backup_configuration_start_time_in_utc
      point_in_time_recovery_enabled = local.settings_backup_configuration_point_in_time_recovery_enabled
      transaction_log_retention_days = var.settings_backup_configuration_transaction_log_retention_days

      backup_retention_settings {
        retained_backups = var.settings_backup_configuration_backup_retention_settings_retained_backups
        retention_unit   = "COUNT"
      }
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
      iterator = flag
      for_each = local.custom_database_flags

      content {
        name  = flag.key
        value = flag.value
      }
    }

  }

  deletion_protection = var.deletion_protection

  lifecycle {
    ignore_changes = [name]
  }
}

locals {
  instance_read_replica = var.name != "" ? "${google_sql_database_instance.instance.name}-read-replica" : ""
}

#This is a component module - these setting will be overridden from the embedding module/repo.
#tfsec:ignore:google-sql-enable-pg-temp-file-logging tfsec:ignore:google-sql-pg-log-connections tfsec:ignore:google-sql-pg-log-lock-waits tfsec:ignore:google-sql-pg-log-disconnections tfsec:ignore:google-sql-pg-log-checkpoints
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
      iterator = flag
      for_each = local.custom_database_flags

      content {
        name  = flag.key
        value = flag.value
      }
    }
  }

  deletion_protection = var.deletion_protection

  lifecycle {
    ignore_changes = [name]
  }
}
