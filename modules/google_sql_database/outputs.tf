output "self_link" {
  description = "The URI of the created resource."
  value       = google_sql_database.database.self_link
}

output "id" {
  description = "an identifier for the resource with format projects/{{project}}/instances/{{instance}}/databases/{{name}}"
  value       = google_sql_database.database.id
}

output "name" {
  description = "The name of the database in the Cloud SQL instance. This does not include the project ID or instance name."
  value       = google_sql_database.database.name
}
