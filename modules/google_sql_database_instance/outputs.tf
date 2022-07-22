output "self_link" {
  description = "The URI of the created resource."
  value       = google_sql_database_instance.instance.self_link
}

output "instance_name" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = google_sql_database_instance.instance.name
}

output "connection_name" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = google_sql_database_instance.instance.connection_name
}

output "service_account_email_address" {
  description = "The service account email address assigned to the instance."
  value       = google_sql_database_instance.instance.service_account_email_address
}

output "first_ip_address" {
  description = "The IPv4 address assigned."
  value       = google_sql_database_instance.instance.first_ip_address
}

output "ip_address" {
  description = "The IPv4 address assigned."
  value       = google_sql_database_instance.instance.ip_address
}

output "public_ip_address" {
  description = " The first public (`PRIMARY`) IPv4 address assigned. This is a workaround for an issue fixed in Terraform 0.12 but also provides a convenient way to access an IP of a specific type without performing filtering in a Terraform config."
  value       = google_sql_database_instance.instance.public_ip_address
}

output "private_ip_address" {
  description = "The first private (`PRIVATE`) IPv4 address assigned. This is a workaround for an issue fixed in Terraform 0.12 but also provides a convenient way to access an IP of a specific type without performing filtering in a Terraform config."
  value       = google_sql_database_instance.instance.private_ip_address
}

output "database_version" {
  description = "Database version, such as MYSQL_8_0 or POSTGRES_*"
  value       = google_sql_database_instance.instance.database_version
}
