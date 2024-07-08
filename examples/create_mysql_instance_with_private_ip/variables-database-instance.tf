variable "database_version" {
  description = "(Required) The MySQL or PostgreSQL version to use. Supported values include `MYSQL_5_6`, `MYSQL_5_7`, `MYSQL_8_0`, `POSTGRES_9_6`,`POSTGRES_10`, `POSTGRES_11`, `POSTGRES_12`, `POSTGRES_13`"
  type        = string
  default     = "MYSQL_8_0"

  validation {
    condition     = can(regex("^MYSQL_|^POSTGRES_", var.database_version))
    error_message = "Support only MySQL or PostgreSQL."
  }
}

variable "settings_tier" {
  description = "(Required) The machine type to use. See tiers for more details and supported versions. Postgres supports only shared-core machine types, and custom machine types"
  type        = string
}

variable "settings_availability_type" {
  description = "(Optional, Default: `ZONAL`) The availability type of the Cloud SQL instance, high availability (`REGIONAL`) or single zone (`ZONAL`)"
  type        = string
  default     = "ZONAL"
}

variable "settings_disk_size" {
  description = "(Optional, Default: `10`) The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased."
  type        = number
  default     = 10
}

variable "settings_disk_type" {
  description = "(Optional, Default: `PD_SSD`) The type of data disk: `PD_SSD` or `PD_HDD`."
  type        = string
  default     = "PD_SSD"
}

variable "settings_backup_configuration_enabled" {
  description = "(Optional) True if backup configuration is enabled."
  type        = bool
  default     = true
}

variable "settings_backup_configuration_binary_log_enabled" {
  description = "(Optional) True if binary logging is enabled. Cannot be used with Postgres."
  type        = bool
  default     = true
}

variable "settings_ip_configuration_ssl_mode" {
  description = " (Optional) Specify how SSL connection should be enforced in DB connections."
  type        = string
  default     = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
}
