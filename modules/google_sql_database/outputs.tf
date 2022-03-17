output "self_link" {
  description = "The URI of the created resource."
  value       = google_sql_database.database.self_link
}

output "id" {
  description = "an identifier for the resource with format projects/{{project}}/instances/{{instance}}/databases/{{name}}"
  value       = google_sql_database.database.id
}
