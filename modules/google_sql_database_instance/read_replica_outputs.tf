output "read_replica_self_link" {
  description = "The URI of the created resource."
  value       = try(google_sql_database_instance.read_replica[0].self_link, "")
}

output "read_replica_instance_name" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = try(google_sql_database_instance.read_replica[0].name, "")
}

output "read_replica_connection_name" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = try(google_sql_database_instance.read_replica[0].connection_name, "")
}

output "read_replica_service_account_email_address" {
  description = "The service account email address assigned to the instance."
  value       = try(google_sql_database_instance.read_replica[0].service_account_email_address, "")
}

output "read_replica_first_ip_address" {
  description = "The IPv4 address assigned."
  value       = try(google_sql_database_instance.read_replica[0].first_ip_address, "")
}

output "read_replica_ip_address" {
  description = "The IPv4 address assigned."
  value       = try(google_sql_database_instance.read_replica[0].ip_address, "")
}

output "read_replica_public_ip_address" {
  description = " The first public (`PRIMARY`) IPv4 address assigned. This is a workaround for an issue fixed in Terraform 0.12 but also provides a convenient way to access an IP of a specific type without performing filtering in a Terraform config."
  value       = try(google_sql_database_instance.read_replica[0].public_ip_address, "")
}

output "read_replica_private_ip_address" {
  description = "The first private (`PRIVATE`) IPv4 address assigned. This is a workaround for an issue fixed in Terraform 0.12 but also provides a convenient way to access an IP of a specific type without performing filtering in a Terraform config."
  value       = try(google_sql_database_instance.read_replica[0].private_ip_address, "")
}
