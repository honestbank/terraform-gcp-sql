terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0, < 7.0"
    }
  }
}

resource "google_compute_network" "vpc_network" {
  # This is a component module - these setting will be overridden from the embedding module/repo.
  #checkov:skip=CKV2_GCP_18:Ensure GCP network defines a firewall and does not use the default firewall

  name        = var.name
  description = var.description

  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode

  mtu                             = var.mtu
  delete_default_routes_on_create = var.delete_default_routes_on_create
}
