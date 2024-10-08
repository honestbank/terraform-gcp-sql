variable "database_version" {
  description = "(Required) The MySQL or PostgreSQL version to use. Supported values include `MYSQL_5_6`, `MYSQL_5_7`, `MYSQL_8_0`, `POSTGRES_9_6`,`POSTGRES_10`, `POSTGRES_11`, `POSTGRES_12`, `POSTGRES_13`"
  type        = string
  default     = "MYSQL_8_0"

  validation {
    condition     = can(regex("^MYSQL_|^POSTGRES_", var.database_version))
    error_message = "Support only MySQL or PostgreSQL."
  }
}

variable "name" {
  description = "(Optional, Computed) The name of the instance. If the name is left blank, Terraform will randomly generate one when the instance is first created. This is done because after a name is used, it cannot be reused for up to one week."
  type        = string
  default     = ""
}

variable "master_instance_name" {
  description = "(Optional) The name of the existing instance that will act as the master in the replication setup. Note, this requires the master to have `binary_log_enabled` set, as well as existing backups."
  type        = string
  default     = ""
}

variable "region" {
  description = "(Optional) The region the instance will sit in"
  type        = string
  default     = ""
}

variable "deletion_protection" {
  description = "(Optional, Default: `true` ) Whether or not to allow Terraform to destroy the instance. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply command that deletes the instance will fail."
  type        = bool
  default     = true
}

variable "settings_tier" {
  description = "(Required) The machine type to use. See tiers for more details and supported versions. Postgres supports only shared-core machine types, and custom machine types"
  type        = string

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^db-", var.settings_tier))
    error_message = "The machine type value must be a valid, starting with \"db-\"."
  }
}

variable "read_replica_settings_tier" {
  description = "(Required) The machine type to use. See tiers for more details and supported versions. Postgres supports only shared-core machine types, and custom machine types"
  type        = string
  default     = ""
}

variable "settings_activation_policy" {
  description = "This specifies when the instance should be active. Set value to ALWAYS to start the instance and NEVER to stop the instance"
  type        = string
  default     = "ALWAYS"
  validation {
    condition     = can(regex("^ALWAYS|^NEVER", var.settings_activation_policy))
    error_message = "Support only `ALWAYS` or `NEVER`."
  }
}

variable "settings_availability_type" {
  description = "(Optional, Default: `ZONAL`) The availability type of the Cloud SQL instance, high availability (`REGIONAL`) or single zone (`ZONAL`)"
  type        = string
  default     = "ZONAL"
  validation {
    condition     = can(regex("^ZONAL|^REGIONAL", var.settings_availability_type))
    error_message = "Support only `ZONAL` or `REGIONAL`."
  }
}

variable "settings_disk_size" {
  description = "(Optional, Default: `10`) The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased."
  type        = number
  default     = 10
}

variable "settings_disk_autoresize" {
  description = "(Optional, Default: `true`) Configuration to increase storage size automatically. Note that future `terraform apply` calls will attempt to resize the disk to the value specified in `disk_size` - if this is set, do not set `disk_size`."
  type        = bool
  default     = true
}

variable "settings_disk_autoresize_limit" {
  description = "(Optional, Default: `0`) The maximum size, in GB, to which storage capacity can be automatically increased. The default value is `0`, which specifies that there is no limit."
  type        = number
  default     = 0
}

variable "settings_disk_type" {
  description = "(Optional, Default: `PD_SSD`) The type of data disk: `PD_SSD` or `PD_HDD`."
  type        = string
  default     = "PD_SSD"
  validation {
    condition     = can(regex("^PD_SSD|^PD_HDD", var.settings_disk_type))
    error_message = "Support only `PD_SSD` or `PD_HDD`."
  }
}

variable "settings_backup_configuration_enabled" {
  description = "(Optional) True if backup configuration is enabled."
  type        = bool
  default     = true
}

variable "settings_backup_configuration_binary_log_enabled" {
  description = "(Optional) True if binary logging is enabled. Cannot be used with PostgreSQL."
  type        = bool
  default     = true
}

variable "settings_backup_configuration_point_in_time_recovery_enabled" {
  description = "(Optional) True if Point-in-time recovery is enabled. Will restart database if enabled after instance creation. Valid only for PostgresSQL instances"
  type        = bool
  default     = true
}

variable "settings_backup_configuration_transaction_log_retention_days" {
  description = "(Optional) The number of days of transaction logs we retain for point in time restore, from 1-7."
  type        = number
  default     = 7
  validation {
    condition     = var.settings_backup_configuration_transaction_log_retention_days >= 1 && var.settings_backup_configuration_transaction_log_retention_days <= 7
    error_message = " transaction log retention must be >= 1 day and <= 7 days."
  }
}

variable "settings_backup_configuration_start_time_in_utc" {
  description = "(Optional) HH:MM format time indicating when backup configuration starts in UTC time."
  type        = string
  default     = "19:00" // GMT+7 is 3AM
  validation {
    condition     = can(regex("^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$", var.settings_backup_configuration_start_time_in_utc))
    error_message = " format time must be HH:MM."
  }
}

variable "settings_backup_configuration_backup_retention_settings_retained_backups" {
  description = "(Optional) Depending on the value of retention_unit, this is used to determine if a backup needs to be deleted. If retention_unit is 'COUNT', we will retain this many backups"
  type        = number
  default     = 7
}

variable "settings_ip_configuration_ssl_mode" {
  description = "(Optional) Specify how SSL connection should be enforced in DB connections. Supported values are `ALLOW_UNENCRYPTED_AND_ENCRYPTED`, `ENCRYPTED_ONLY`, `TRUSTED_CLIENT_CERTIFICATE_REQUIRED`."
  type        = string
  default     = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
  validation {
    condition     = can(regex("ALLOW_UNENCRYPTED_AND_ENCRYPTED|ENCRYPTED_ONLY|TRUSTED_CLIENT_CERTIFICATE_REQUIRED", var.settings_ip_configuration_ssl_mode))
    error_message = "Support only `ALLOW_UNENCRYPTED_AND_ENCRYPTED`, `ENCRYPTED_ONLY`, `TRUSTED_CLIENT_CERTIFICATE_REQUIRED`."
  }
}

variable "settings_ip_configuration_ipv4_enabled" {
  description = "Whether this Cloud SQL instance should be assigned a public IPV4 address. At least `ipv4_enabled` must be enabled or a `private_network` must be configured."
  type        = bool
  default     = false
}

variable "read_replica_settings_ip_configuration_ipv4_enabled" {
  description = "Whether this Cloud SQL instance should be assigned a public IPV4 address. At least `ipv4_enabled` must be enabled or a `private_network` must be configured."
  type        = bool
  default     = false
}

variable "settings_ip_configuration_private_network" {
  description = "The VPC network from which the Cloud SQL instance is accessible for private IP. For example, projects/myProject/global/networks/default. Specifying a network enables private IP."
  type        = string
  default     = ""
}

variable "settings_ip_configuration_allocated_ip_range" {
  description = "(Optional) The name of the allocated ip range for the private ip CloudSQL instance. For example: `google-managed-services-default`. If set, the cloned instance ip will be created in the allocated range. The range name must comply with RFC 1035. Specifically, the name must be 1-63 characters long."
  type        = string
  default     = ""
}

variable "settings_ip_configuration_enable_private_path_for_google_cloud_services" {
  description = "(Optional) Whether Google Cloud services such as BigQuery are allowed to access data in this Cloud SQL instance over a private IP connection. SQLSERVER database type is not supported."
  type        = string
  default     = true
}

variable "settings_database_flags" {
  description = "List of Cloud SQL flags that are applied to the database server. See [more details](https://cloud.google.com/sql/docs/mysql/flags)"
  type        = map(any)
  default     = {}
}

variable "enable_read_replica" {
  description = "Enable or Disable Read Replica"
  type        = bool
  default     = false
}

variable "settings_insights_config_query_string_length" {
  description = "(Optional) Maximum query length stored in bytes."
  type        = number
  default     = 1024
  validation {
    condition     = var.settings_insights_config_query_string_length >= 256 && var.settings_insights_config_query_string_length <= 4500
    error_message = " query string length must be >= 256 and <= 4500."
  }
}

variable "settings_insights_config_query_plans_per_minute" {
  description = "(Optional) Maximum number of query plans generated by Insights per minute"
  type        = number
  default     = 10
  validation {
    condition     = var.settings_insights_config_query_plans_per_minute >= 0 && var.settings_insights_config_query_plans_per_minute <= 20
    error_message = " query plans per minute must be >= 0 and <= 20."
  }
}

variable "settings_maintenance_window_day" {
  description = "(Optional) The day of week (1-7) for maintenance window to start.Starting on Monday"
  type        = number
  default     = 1
  validation {
    condition     = var.settings_maintenance_window_day >= 1 && var.settings_maintenance_window_day <= 7
    error_message = " maintenance window day must be >= 1 and <= 7."
  }
}

variable "settings_maintenance_window_hour" {
  description = "(Optional) The hour of day (0-23) maintenance window starts.The maintenance window is specified in UTC time"
  type        = number
  default     = 3
  validation {
    condition     = var.settings_maintenance_window_hour >= 0 && var.settings_maintenance_window_hour <= 23
    error_message = " maintenance window hour must be >= 0 and <= 23."
  }
}
