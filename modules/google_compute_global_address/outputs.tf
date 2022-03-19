output "self_link" {
  description = "The URI of the created resource."
  value       = google_compute_global_address.default_network.self_link
}

output "id" {
  description = "an identifier for the resource with format `projects/{{project}}/global/addresses/{{name}}`."
  value       = google_compute_global_address.default_network.id
}

output "creation_timestamp" {
  description = "Creation timestamp in RFC3339 text format."
  value       = google_compute_global_address.default_network.creation_timestamp
}
