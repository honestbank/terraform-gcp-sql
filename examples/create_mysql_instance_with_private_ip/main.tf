resource "random_id" "instance_suffix" {
  byte_length = 4
}

resource "random_id" "random_string" {
  byte_length = 12
}

module "google_compute_network_private_network" {
  source = "../../modules/google_compute_network"

  name = "private-network-${random_id.instance_suffix.hex}"
}

module "google_compute_global_address_private_ip_address" {
  source = "../../modules/google_compute_global_address"

  name          = "private-ip-address-${random_id.instance_suffix.hex}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.google_compute_network_private_network.id
}

module "google_service_networking_connection_private_vpc_connection" {
  source = "../../modules/google_service_networking_connection"

  network                 = module.google_compute_network_private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [module.google_compute_global_address_private_ip_address.name]
}

module "test_sql_database_instance_private_ip" {
  source = "../../modules/google_sql_database_instance"

  name = "sql-private-${random_id.instance_suffix.hex}"

  depends_on = [module.google_service_networking_connection_private_vpc_connection]

  settings_backup_configuration_binary_log_enabled = var.settings_backup_configuration_binary_log_enabled
  settings_backup_configuration_enabled            = var.settings_backup_configuration_enabled
  settings_ip_configuration_ipv4_enabled           = false
  settings_ip_configuration_private_network        = module.google_compute_network_private_network.id
  settings_ip_configuration_require_ssl            = var.settings_ip_configuration_require_ssl
  settings_tier                                    = var.settings_tier
  deletion_protection                              = false
}

module "test_sql_database" {
  source = "../../modules/google_sql_database"

  depends_on = [
    module.test_sql_user
  ]

  instance_name = module.test_sql_database_instance_private_ip.instance_name
  name          = var.database_name
}

module "test_sql_user" {
  source = "../../modules/google_sql_user"

  depends_on = [
    module.test_sql_database_instance_private_ip
  ]

  instance_name = module.test_sql_database_instance_private_ip.instance_name
  name          = var.user_name
  password      = random_id.random_string.hex
  type          = var.user_type
}
