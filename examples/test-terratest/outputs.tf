output "instance_suffix" {
  description = "Random string"
  value       = random_id.instance_suffix.hex
}

output "sql_database_instance_master_instance_name" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = google_sql_database_instance.main.name
}

output "sql_database_instance_master_self_link" {
  description = "The URI of the created resource."
  value       = google_sql_database_instance.main.self_link
}

output "sql_database_instance_master_service_account_email_address" {
  description = "The service account email address assigned to the instance."
  value       = google_sql_database_instance.main.service_account_email_address
}

output "sql_database_instance_master_connection_name" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = google_sql_database_instance.main.connection_name
}

output "sql_database_instance_master_first_ip_address" {
  description = "The IPv4 address assigned."
  value       = google_sql_database_instance.main.first_ip_address
}

output "sql_database_instance_master_private_ip_address" {
  description = "The first private (`PRIVATE`) IPv4 address assigned."
  value       = google_sql_database_instance.main.private_ip_address
}

output "sql_database_instance_master_public_ip_address" {
  description = "The first public (`PRIMARY`) IPv4 address assigned."
  value       = google_sql_database_instance.main.public_ip_address
}
