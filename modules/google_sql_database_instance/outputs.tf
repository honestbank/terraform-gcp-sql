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
