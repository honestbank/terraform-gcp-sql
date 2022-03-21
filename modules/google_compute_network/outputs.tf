output "self_link" {
  description = "The URI of the created resource."
  value       = google_compute_network.vpc_network.self_link
}

output "gateway_ipv4" {
  description = "The gateway address for default routing out of the network. This value is selected by GCP."
  value       = google_compute_network.vpc_network.gateway_ipv4
}

output "id" {
  description = "an identifier for the resource with format `projects/{{project}}/global/networks/{{name}}`."
  value       = google_compute_network.vpc_network.id
}
