terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.48, < 6.0"
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
    "cloudsql.enable_pgaudit" = "on"
    log_hostname              = "on"
    log_duration              = "on"
    log_temp_files            = "0"
    log_connections           = "on"
    log_lock_waits            = "on"
    log_disconnections        = "on"
    log_checkpoints           = "on"
    "pgaudit.log"             = "all"
    "pgaudit.log_client"      = "on"
    "pgaudit.log_level"       = "notice"
  }

  settings_backup_configuration_binary_log_enabled             = local.is_postgres ? false : var.settings_backup_configuration_binary_log_enabled
  settings_backup_configuration_point_in_time_recovery_enabled = local.is_postgres ? var.settings_backup_configuration_point_in_time_recovery_enabled : false

  tmp_database_flags    = local.is_postgres ? local.postgres_database_flags : local.mysql_database_flags
  custom_database_flags = merge(var.settings_database_flags, local.tmp_database_flags)
}

#These setting will override from code
#tfsec:ignore:google-sql-enable-pg-temp-file-logging
#tfsec:ignore:google-sql-pg-log-connections
#tfsec:ignore:google-sql-pg-log-lock-waits
#tfsec:ignore:google-sql-pg-log-disconnections
#tfsec:ignore:google-sql-pg-log-checkpoints
resource "google_sql_database_instance" "instance" {
  # This is a component module - these setting will be overridden from the embedding module/repo.
  #checkov:skip=CKV_GCP_51:Ensure PostgreSQL database 'log_checkpoints' flag is set to 'on'
  #checkov:skip=CKV_GCP_52:Ensure PostgreSQL database 'log_connections' flag is set to 'on'
  #checkov:skip=CKV_GCP_53:Ensure PostgreSQL database 'log_disconnections' flag is set to 'on'
  #checkov:skip=CKV_GCP_54:Ensure PostgreSQL database 'log_lock_waits' flag is set to 'on'
  #checkov:skip=CKV_GCP_108:Ensure hostnames are logged for GCP PostgreSQL databases 'log_hostname' flag is set to 'on'
  #checkov:skip=CKV_GCP_109:Ensure the GCP PostgreSQL database log levels are set to ERROR or lower 'pgaudit.log_level' flag is set to 'notice'
  #checkov:skip=CKV_GCP_110:Ensure pgAudit is enabled for your GCP PostgreSQL database 'cloudsql.enable_pgaudit' flag is set to 'on'
  #checkov:skip=CKV_GCP_111:Ensure GCP PostgreSQL logs SQL statements 'pgaudit.log' flag is set to 'all'
  #checkov:skip=CKV2_GCP_20:Ensure MySQL DB instance has point-in-time recovery backup configured
  #checkov:skip=CKV2_GCP_13:Ensure PostgreSQL database flag 'log_duration' is set to 'on'
  #checkov:skip=CKV_GCP_79: "Ensure SQL database is using latest Major version"

  database_version = var.database_version

  name   = var.name
  region = var.region

  master_instance_name = var.master_instance_name

  settings {
    availability_type           = var.settings_availability_type
    deletion_protection_enabled = var.deletion_protection
    disk_autoresize             = var.settings_disk_autoresize
    disk_autoresize_limit       = var.settings_disk_autoresize_limit
    disk_type                   = var.settings_disk_type
    disk_size                   = var.settings_disk_size
    tier                        = var.settings_tier

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

      private_network                               = var.settings_ip_configuration_private_network
      allocated_ip_range                            = var.settings_ip_configuration_allocated_ip_range
      enable_private_path_for_google_cloud_services = var.settings_ip_configuration_enable_private_path_for_google_cloud_services
    }

    insights_config {
      query_insights_enabled  = true
      query_string_length     = var.settings_insights_config_query_string_length
      query_plans_per_minute  = var.settings_insights_config_query_plans_per_minute
      record_application_tags = true
      record_client_address   = true
    }

    dynamic "database_flags" {
      iterator = flag
      for_each = local.custom_database_flags

      content {
        name  = flag.key
        value = flag.value
      }
    }

    maintenance_window {
      day          = var.settings_maintenance_window_day
      hour         = var.settings_maintenance_window_hour
      update_track = "stable"
    }
  }

  deletion_protection = var.deletion_protection

  lifecycle {
    ignore_changes = [
      name,
      settings.0.disk_size,
      settings.0.tier,
    ]
  }
}

locals {
  instance_read_replica = var.name != "" ? "${google_sql_database_instance.instance.name}-read-replica" : ""
}

#This is a component module - these setting will be overridden from the embedding module/repo.
#tfsec:ignore:google-sql-enable-pg-temp-file-logging tfsec:ignore:google-sql-pg-log-connections tfsec:ignore:google-sql-pg-log-lock-waits tfsec:ignore:google-sql-pg-log-disconnections tfsec:ignore:google-sql-pg-log-checkpoints
resource "google_sql_database_instance" "read_replica" {
  #This is a component module - these setting will be overridden from the embedding module/repo.
  #checkov:skip=CKV_GCP_51:Ensure PostgreSQL database 'log_checkpoints' flag is set to 'on'
  #checkov:skip=CKV_GCP_52:Ensure PostgreSQL database 'log_connections' flag is set to 'on'
  #checkov:skip=CKV_GCP_53:Ensure PostgreSQL database 'log_disconnections' flag is set to 'on'
  #checkov:skip=CKV_GCP_54:Ensure PostgreSQL database 'log_lock_waits' flag is set to 'on'
  #checkov:skip=CKV_GCP_108:Ensure hostnames are logged for GCP PostgreSQL databases 'log_hostname' flag is set to 'on'
  #checkov:skip=CKV_GCP_109:Ensure the GCP PostgreSQL database log levels are set to ERROR or lower 'pgaudit.log_level' flag is set to 'notice'
  #checkov:skip=CKV_GCP_110:Ensure pgAudit is enabled for your GCP PostgreSQL database 'cloudsql.enable_pgaudit' flag is set to 'on'
  #checkov:skip=CKV_GCP_111:Ensure GCP PostgreSQL logs SQL statements 'pgaudit.log' flag is set to 'all'
  #checkov:skip=CKV2_GCP_20:Ensure MySQL DB instance has point-in-time recovery backup configured
  #checkov:skip=CKV2_GCP_13:Ensure PostgreSQL database flag 'log_duration' is set to 'on'
  #checkov:skip=CKV_GCP_79: "Ensure SQL database is using latest Major version"

  depends_on = [
    google_sql_database_instance.instance
  ]

  count = var.enable_read_replica ? 1 : 0

  database_version = var.database_version

  name   = local.instance_read_replica
  region = var.region

  master_instance_name = google_sql_database_instance.instance.name

  settings {

    tier                        = var.read_replica_settings_tier
    disk_size                   = var.settings_disk_autoresize ? null : var.settings_disk_size
    disk_autoresize             = var.settings_disk_autoresize
    disk_type                   = var.settings_disk_type
    deletion_protection_enabled = var.deletion_protection

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

      private_network                               = var.settings_ip_configuration_private_network
      enable_private_path_for_google_cloud_services = var.settings_ip_configuration_enable_private_path_for_google_cloud_services
    }

    insights_config {
      query_insights_enabled  = true
      query_string_length     = var.settings_insights_config_query_string_length
      query_plans_per_minute  = var.settings_insights_config_query_plans_per_minute
      record_application_tags = true
      record_client_address   = true
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
    ignore_changes = [
      name,
      settings.0.disk_size,
      settings.0.tier,
    ]
  }
}
