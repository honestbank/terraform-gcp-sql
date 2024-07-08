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

module "google_compute_global_address_private_ip" {
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
  reserved_peering_ranges = [module.google_compute_global_address_private_ip.name]
  deletion_policy         = "ABANDON"
}

module "sql_database_instance" {
  source = "../../modules/google_sql_database_instance"

  depends_on = [
    module.google_service_networking_connection_private_vpc_connection
  ]

  name = "sql-rr-${random_id.instance_suffix.hex}"
  #checkov:skip=CKV_GCP_79:Ensure SQL database is using latest Major version"
  database_version = "MYSQL_8_0"

  settings_backup_configuration_binary_log_enabled = var.settings_backup_configuration_binary_log_enabled
  settings_backup_configuration_enabled            = var.settings_backup_configuration_enabled

  settings_backup_configuration_start_time_in_utc                          = "03:00"
  settings_backup_configuration_transaction_log_retention_days             = 5
  settings_backup_configuration_backup_retention_settings_retained_backups = 10

  # Requirements for using the Cloud SQL Auth proxy
  # https://cloud.google.com/sql/docs/mysql/sql-proxy#requirements

  settings_ip_configuration_ipv4_enabled    = false
  settings_ip_configuration_private_network = module.google_compute_network_private_network.id

  #checkov:skip=CKV_GCP_6:Ensure all Cloud SQL database instance requires all incoming connections to use SSL"
  settings_ip_configuration_ssl_mode = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"

  settings_availability_type = var.settings_availability_type

  settings_tier       = var.settings_tier
  deletion_protection = false

  enable_read_replica                                 = true
  read_replica_settings_ip_configuration_ipv4_enabled = true
  read_replica_settings_tier                          = var.settings_tier
}

module "sql_database" {
  source = "../../modules/google_sql_database"

  depends_on = [
    module.sql_user
  ]

  instance_name = module.sql_database_instance.instance_name
  name          = var.database_name
}

module "sql_user" {
  source = "../../modules/google_sql_user"

  depends_on = [
    module.sql_database_instance
  ]

  instance_name = module.sql_database_instance.instance_name
  name          = var.user_name
  password      = random_id.random_string.hex
  host          = "%"
  type          = var.user_type
}
