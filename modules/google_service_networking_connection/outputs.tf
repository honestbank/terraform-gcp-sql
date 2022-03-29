output "peering" {
  description = "(Computed) The name of the VPC Network Peering connection that was created by the service producer."
  value       = google_service_networking_connection.network.peering
}
