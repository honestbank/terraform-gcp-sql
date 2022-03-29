terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0.0"
    }
  }
}

resource "google_compute_global_address" "default_network" {
  name          = var.name
  description   = var.description
  address_type  = var.address_type
  purpose       = var.purpose
  network       = var.network
  address       = var.address
  ip_version    = var.ip_version
  prefix_length = var.prefix_length
}
