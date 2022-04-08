variable "connection_id" {
  description = "ID of the BigQuery connection"
  type        = string
}

variable "location" {
  description = "GCP location, e.g. asia-southeast2"
  type        = string
  default     = "asia-southeast2"
}

variable "description" {
  description = "Description of the BigQuery connection"
  type        = string
  default     = ""
}

variable "database_instance_id" {
  description = "ID of the CloudSQL INSTANCE. Note: not the database inside the instance, but the instance."
  type        = string
}

variable "database_name" {
  description = "Name of the database inside the CloudSQL instance, NOT the instance name / ID."
  type        = string
}

variable "sql_user_credentials" {
  description = "Credentials of the SQL User in the database inside the instance - Note: The user must exist prior to building this component."
  type = object({
    user_name : string
    password : string
  })
  sensitive = true
}

