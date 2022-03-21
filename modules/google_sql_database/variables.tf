variable "name" {
  description = "(Required) The name of the database in the Cloud SQL instance. This does not include the project ID or instance name."
  type        = string
}

variable "instance_name" {
  description = "(Required) The name of the Cloud SQL instance. This does not include the project ID"
  type        = string
}

variable "charset" {
  description = "(Optional) The charset value. See MySQL's Supported Character Sets and Collations and Postgres' Character Set Support for more details and supported values. Postgres databases only support a value of UTF8 at creation time."
  type        = string
  default     = ""
}

variable "collation" {
  description = "(Optional) The collation value. See MySQL's Supported Character Sets and Collations and Postgres' Collation Support for more details and supported values. Postgres databases only support a value of en_US.UTF8 at creation time."
  type        = string
  default     = ""
}
