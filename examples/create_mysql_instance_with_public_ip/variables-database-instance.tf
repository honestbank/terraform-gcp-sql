variable "database_version" {
  description = "(Required) The MySQL or PostgreSQL version to use. Supported values include `MYSQL_5_6`, `MYSQL_5_7`, `MYSQL_8_0`, `POSTGRES_9_6`,`POSTGRES_10`, `POSTGRES_11`, `POSTGRES_12`, `POSTGRES_13`"
  type        = string
  default     = "MYSQL_8_0"

  validation {
    condition     = can(regex("^MYSQL_|^POSTGRES_", var.database_version))
    error_message = "Support only MySQL or PostgreSQL."
  }
}

variable "deletion_protection" {
  description = "(Optional) Whether or not to allow Terraform to destroy the instance. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply command that deletes the instance will fail."
  type        = bool
  default     = false
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

variable "settings_ip_configuration_require_ssl" {
  description = "(Optional) Whether SSL connections over IP are enforced or not."
  type        = bool
  default     = true
}

variable "settings_ip_configuration_ipv4_enabled" {
  description = "(Optional) Whether this Cloud SQL instance should be assigned a public IPV4 address. At least `ipv4_enabled` must be enabled or a `private_network` must be configured."
  type        = bool
  default     = false
}

variable "settings_ip_configuration_private_network" {
  description = "The VPC network from which the Cloud SQL instance is accessible for private IP. For example, projects/myProject/global/networks/default. Specifying a network enables private IP."
  type        = string
  default     = ""
}
