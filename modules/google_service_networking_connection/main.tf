terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0, < 7.0"
    }
  }
}

resource "google_service_networking_connection" "network" {
  network                 = var.network
  service                 = var.service
  reserved_peering_ranges = var.reserved_peering_ranges
  deletion_policy         = var.deletion_policy
}
