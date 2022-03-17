output "sql_user" {
  description = "The name of the user."
  value       = google_sql_user.users.name
}

output "sql_password" {
  description = "The password for the user"
  value       = google_sql_user.users.password
  sensitive   = true
}

output "user_type" {
  description = "The user type"
  value       = google_sql_user.users.type
}
