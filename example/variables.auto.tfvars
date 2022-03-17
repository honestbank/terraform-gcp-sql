database_version = "MYSQL_8_0"
instance_name    = "test-terraform-cloud-sql"

database_name_1 = "test-cloud-db-first"
database_name_2 = "test-cloud-db-second"

user_host = "%"
user_type = "BUILT_IN"
user_name = "test-cloud-sql-user"

deletion_protection = false

settings_tier                                    = "db-f1-micro"
settings_availability_type                       = "ZONAL"
settings_disk_size                               = 10
settings_disk_type                               = "PD_SSD"
settings_backup_configuration_enabled            = true
settings_backup_configuration_binary_log_enabled = true
settings_ip_configuration_require_ssl            = true
settings_ip_configuration_ipv4_enabled           = true
settings_ip_configuration_private_network        = ""
