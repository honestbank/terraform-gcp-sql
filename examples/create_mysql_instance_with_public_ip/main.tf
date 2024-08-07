resource "random_id" "instance_suffix" {
  byte_length = 4
}

resource "random_id" "random_string" {
  byte_length = 12
}

module "test_sql_database_instance" {

  source = "../../modules/google_sql_database_instance"

  name = "sql-public-${random_id.instance_suffix.hex}"

  settings_backup_configuration_binary_log_enabled = var.settings_backup_configuration_binary_log_enabled
  settings_backup_configuration_enabled            = var.settings_backup_configuration_enabled
  settings_ip_configuration_ipv4_enabled           = var.settings_ip_configuration_ipv4_enabled
  settings_ip_configuration_private_network        = var.settings_ip_configuration_private_network
  settings_ip_configuration_ssl_mode               = var.settings_ip_configuration_ssl_mode
  settings_tier                                    = var.settings_tier
  deletion_protection                              = false
}

module "test_sql_database_1" {
  source = "../../modules/google_sql_database"

  depends_on = [
    module.test_sql_user
  ]

  instance_name = module.test_sql_database_instance.instance_name
  name          = var.database_name_1
}

module "test_sql_database_2" {
  source = "../../modules/google_sql_database"

  depends_on = [
    module.test_sql_user
  ]

  instance_name = module.test_sql_database_instance.instance_name
  name          = var.database_name_2
}

module "test_sql_user" {
  depends_on = [
    module.test_sql_database_instance
  ]

  source        = "../../modules/google_sql_user"
  instance_name = module.test_sql_database_instance.instance_name
  name          = var.user_name
  password      = random_id.random_string.hex
  type          = var.user_type
}
