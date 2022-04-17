output "random_string" {
  description = "Random string"
  value       = random_id.random_string.hex
}

output "sql_database_instance_master_instance_name" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = module.sql_database_instance.instance_name
}

output "sql_database_instance_master_self_link" {
  description = "The URI of the created resource."
  value       = module.sql_database_instance.self_link
}

output "sql_database_instance_master_service_account_email_address" {
  description = "The service account email address assigned to the instance."
  value       = module.sql_database_instance.service_account_email_address
}

output "sql_database_instance_master_connection_name" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = module.sql_database_instance.connection_name
}

output "sql_database_instance_master_first_ip_address" {
  description = "The IPv4 address assigned."
  value       = module.sql_database_instance.first_ip_address
}

output "sql_database_instance_master_private_ip_address" {
  description = "The first private (`PRIVATE`) IPv4 address assigned."
  value       = module.sql_database_instance.private_ip_address
}

output "sql_database_instance_master_public_ip_address" {
  description = "The first public (`PRIMARY`) IPv4 address assigned."
  value       = module.sql_database_instance.public_ip_address
}

output "sql_database_master_self_link" {
  description = "The URI of the created resource."
  value       = module.sql_database.self_link
}

output "sql_database_master_id" {
  description = "an identifier for the resource with format projects/{{project}}/instances/{{instance}}/databases/{{name}}"
  value       = module.sql_database.id
}

output "sql_user_name" {
  description = "The name of the user."
  value       = module.sql_user.sql_user
}

output "sql_user_password" {
  description = "The password for the user"
  value       = module.sql_user.sql_password
  sensitive   = true
}

output "sql_user_type" {
  description = "The user type"
  value       = module.sql_user.user_type
}

##########################
# Read Replica Outputs
##########################

output "sql_database_instance_read_replica_instance_name" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = module.sql_database_instance.read_replica_instance_name
}

output "sql_database_instance_read_replica_self_link" {
  description = "The URI of the created resource."
  value       = module.sql_database_instance.read_replica_self_link
}

output "sql_database_instance_read_replica_service_account_email_address" {
  description = "The service account email address assigned to the instance."
  value       = module.sql_database_instance.read_replica_service_account_email_address
}

output "sql_database_instance_read_replica_connection_name" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = module.sql_database_instance.read_replica_connection_name
}

output "sql_database_instance_read_replica_first_ip_address" {
  description = "The IPv4 address assigned."
  value       = module.sql_database_instance.read_replica_first_ip_address
}

output "sql_database_instance_read_replica_private_ip_address" {
  description = "The first private (`PRIVATE`) IPv4 address assigned."
  value       = module.sql_database_instance.read_replica_private_ip_address
}

output "sql_database_instance_read_replica_public_ip_address" {
  description = "The first public (`PRIMARY`) IPv4 address assigned."
  value       = module.sql_database_instance.read_replica_public_ip_address
}
