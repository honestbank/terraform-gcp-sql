output "random_string" {
  description = "Random string"
  value       = random_id.random_string.hex
}

output "test_terraform_sql_instance_name" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = module.test_sql_database_instance.instance_name
}

output "test_terraform_sql_self_link" {
  description = "The URI of the created resource."
  value       = module.test_sql_database_instance.self_link
}

output "test_terraform_sql_service_account_email_address" {
  description = "The service account email address assigned to the instance."
  value       = module.test_sql_database_instance.service_account_email_address
}

output "test_terraform_sql_connection_name" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = module.test_sql_database_instance.connection_name
}

output "test_terraform_sql_first_ip_address" {
  description = "The IPv4 address assigned."
  value       = module.test_sql_database_instance.first_ip_address
}

output "test_sql_database_instance_private_ip_private_ip_address" {
  description = "The first private (`PRIVATE`) IPv4 address assigned."
  value       = module.test_sql_database_instance.private_ip_address
}

output "test_sql_database_instance_private_ip_public_ip_address" {
  description = "The first public (`PRIMARY`) IPv4 address assigned."
  value       = module.test_sql_database_instance.public_ip_address
}

output "test_sql_database_1_self_link" {
  description = "The URI of the created resource."
  value       = module.test_sql_database_1.self_link
}

output "test_sql_database_1_id" {
  description = "an identifier for the resource with format projects/{{project}}/instances/{{instance}}/databases/{{name}}"
  value       = module.test_sql_database_1.id
}

output "test_sql_database_2_self_link" {
  description = "The URI of the created resource."
  value       = module.test_sql_database_2.self_link
}

output "test_sql_database_2_id" {
  description = "an identifier for the resource with format projects/{{project}}/instances/{{instance}}/databases/{{name}}"
  value       = module.test_sql_database_2.id
}

output "test_sql_user_name" {
  description = "The name of the user."
  value       = module.test_sql_user.sql_user
}

output "test_sql_user_password" {
  description = "The password for the user"
  value       = module.test_sql_user.sql_password
  sensitive   = true
}

output "test_sql_user_type" {
  description = "The user type"
  value       = module.test_sql_user.user_type
}
