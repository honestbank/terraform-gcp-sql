terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0.0"
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name        = var.name
  description = var.description

  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode

  mtu                             = var.mtu
  delete_default_routes_on_create = var.delete_default_routes_on_create
}
