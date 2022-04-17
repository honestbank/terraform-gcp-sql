variable "user_host" {
  description = "(Required) The host the user can connect from. This is only supported for MySQL instances. Don't set this field for PostgreSQL instances. Can be an IP address. Changing this forces a new resource to be created."
  type        = string
  nullable    = true
}

variable "user_type" {
  description = "(Optional, default=`BUILT_IN`) The user type. It determines the method to authenticate the user during login. The default is the database's built-in user type. Flags include `BUILT_IN`, `CLOUD_IAM_USER`, or `CLOUD_IAM_SERVICE_ACCOUNT`."
  type        = string
  default     = "BUILT_IN"
}

variable "user_name" {
  description = "(Required) The name of the database in the Cloud SQL instance. This does not include the project ID or instance name."
  type        = string
}
