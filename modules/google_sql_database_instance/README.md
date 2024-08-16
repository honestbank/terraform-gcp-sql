<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.48, < 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.48, < 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_database_instance.instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_database_instance.read_replica](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | (Required) The MySQL or PostgreSQL version to use. Supported values include `MYSQL_5_6`, `MYSQL_5_7`, `MYSQL_8_0`, `POSTGRES_9_6`,`POSTGRES_10`, `POSTGRES_11`, `POSTGRES_12`, `POSTGRES_13` | `string` | `"MYSQL_8_0"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | (Optional, Default: `true` ) Whether or not to allow Terraform to destroy the instance. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply command that deletes the instance will fail. | `bool` | `true` | no |
| <a name="input_enable_read_replica"></a> [enable\_read\_replica](#input\_enable\_read\_replica) | Enable or Disable Read Replica | `bool` | `false` | no |
| <a name="input_master_instance_name"></a> [master\_instance\_name](#input\_master\_instance\_name) | (Optional) The name of the existing instance that will act as the master in the replication setup. Note, this requires the master to have `binary_log_enabled` set, as well as existing backups. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional, Computed) The name of the instance. If the name is left blank, Terraform will randomly generate one when the instance is first created. This is done because after a name is used, it cannot be reused for up to one week. | `string` | `""` | no |
| <a name="input_read_replica_settings_ip_configuration_ipv4_enabled"></a> [read\_replica\_settings\_ip\_configuration\_ipv4\_enabled](#input\_read\_replica\_settings\_ip\_configuration\_ipv4\_enabled) | Whether this Cloud SQL instance should be assigned a public IPV4 address. At least `ipv4_enabled` must be enabled or a `private_network` must be configured. | `bool` | `false` | no |
| <a name="input_read_replica_settings_tier"></a> [read\_replica\_settings\_tier](#input\_read\_replica\_settings\_tier) | (Required) The machine type to use. See tiers for more details and supported versions. Postgres supports only shared-core machine types, and custom machine types | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region the instance will sit in | `string` | `""` | no |
| <a name="input_settings_activation_policy"></a> [settings\_activation\_policy](#input\_settings\_activation\_policy) | This specifies when the instance should be active. Set value to ALWAYS to start the instance and NEVER to stop the instance | `string` | `"ALWAYS"` | no |
| <a name="input_settings_availability_type"></a> [settings\_availability\_type](#input\_settings\_availability\_type) | (Optional, Default: `ZONAL`) The availability type of the Cloud SQL instance, high availability (`REGIONAL`) or single zone (`ZONAL`) | `string` | `"ZONAL"` | no |
| <a name="input_settings_backup_configuration_backup_retention_settings_retained_backups"></a> [settings\_backup\_configuration\_backup\_retention\_settings\_retained\_backups](#input\_settings\_backup\_configuration\_backup\_retention\_settings\_retained\_backups) | (Optional) Depending on the value of retention\_unit, this is used to determine if a backup needs to be deleted. If retention\_unit is 'COUNT', we will retain this many backups | `number` | `7` | no |
| <a name="input_settings_backup_configuration_binary_log_enabled"></a> [settings\_backup\_configuration\_binary\_log\_enabled](#input\_settings\_backup\_configuration\_binary\_log\_enabled) | (Optional) True if binary logging is enabled. Cannot be used with PostgreSQL. | `bool` | `true` | no |
| <a name="input_settings_backup_configuration_enabled"></a> [settings\_backup\_configuration\_enabled](#input\_settings\_backup\_configuration\_enabled) | (Optional) True if backup configuration is enabled. | `bool` | `true` | no |
| <a name="input_settings_backup_configuration_point_in_time_recovery_enabled"></a> [settings\_backup\_configuration\_point\_in\_time\_recovery\_enabled](#input\_settings\_backup\_configuration\_point\_in\_time\_recovery\_enabled) | (Optional) True if Point-in-time recovery is enabled. Will restart database if enabled after instance creation. Valid only for PostgresSQL instances | `bool` | `true` | no |
| <a name="input_settings_backup_configuration_start_time_in_utc"></a> [settings\_backup\_configuration\_start\_time\_in\_utc](#input\_settings\_backup\_configuration\_start\_time\_in\_utc) | (Optional) HH:MM format time indicating when backup configuration starts in UTC time. | `string` | `"19:00"` | no |
| <a name="input_settings_backup_configuration_transaction_log_retention_days"></a> [settings\_backup\_configuration\_transaction\_log\_retention\_days](#input\_settings\_backup\_configuration\_transaction\_log\_retention\_days) | (Optional) The number of days of transaction logs we retain for point in time restore, from 1-7. | `number` | `7` | no |
| <a name="input_settings_database_flags"></a> [settings\_database\_flags](#input\_settings\_database\_flags) | List of Cloud SQL flags that are applied to the database server. See [more details](https://cloud.google.com/sql/docs/mysql/flags) | `map(any)` | `{}` | no |
| <a name="input_settings_disk_autoresize"></a> [settings\_disk\_autoresize](#input\_settings\_disk\_autoresize) | (Optional, Default: `true`) Configuration to increase storage size automatically. Note that future `terraform apply` calls will attempt to resize the disk to the value specified in `disk_size` - if this is set, do not set `disk_size`. | `bool` | `true` | no |
| <a name="input_settings_disk_autoresize_limit"></a> [settings\_disk\_autoresize\_limit](#input\_settings\_disk\_autoresize\_limit) | (Optional, Default: `0`) The maximum size, in GB, to which storage capacity can be automatically increased. The default value is `0`, which specifies that there is no limit. | `number` | `0` | no |
| <a name="input_settings_disk_size"></a> [settings\_disk\_size](#input\_settings\_disk\_size) | (Optional, Default: `10`) The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased. | `number` | `10` | no |
| <a name="input_settings_disk_type"></a> [settings\_disk\_type](#input\_settings\_disk\_type) | (Optional, Default: `PD_SSD`) The type of data disk: `PD_SSD` or `PD_HDD`. | `string` | `"PD_SSD"` | no |
| <a name="input_settings_insights_config_query_plans_per_minute"></a> [settings\_insights\_config\_query\_plans\_per\_minute](#input\_settings\_insights\_config\_query\_plans\_per\_minute) | (Optional) Maximum number of query plans generated by Insights per minute | `number` | `10` | no |
| <a name="input_settings_insights_config_query_string_length"></a> [settings\_insights\_config\_query\_string\_length](#input\_settings\_insights\_config\_query\_string\_length) | (Optional) Maximum query length stored in bytes. | `number` | `1024` | no |
| <a name="input_settings_ip_configuration_allocated_ip_range"></a> [settings\_ip\_configuration\_allocated\_ip\_range](#input\_settings\_ip\_configuration\_allocated\_ip\_range) | (Optional) The name of the allocated ip range for the private ip CloudSQL instance. For example: `google-managed-services-default`. If set, the cloned instance ip will be created in the allocated range. The range name must comply with RFC 1035. Specifically, the name must be 1-63 characters long. | `string` | `""` | no |
| <a name="input_settings_ip_configuration_enable_private_path_for_google_cloud_services"></a> [settings\_ip\_configuration\_enable\_private\_path\_for\_google\_cloud\_services](#input\_settings\_ip\_configuration\_enable\_private\_path\_for\_google\_cloud\_services) | (Optional) Whether Google Cloud services such as BigQuery are allowed to access data in this Cloud SQL instance over a private IP connection. SQLSERVER database type is not supported. | `string` | `true` | no |
| <a name="input_settings_ip_configuration_ipv4_enabled"></a> [settings\_ip\_configuration\_ipv4\_enabled](#input\_settings\_ip\_configuration\_ipv4\_enabled) | Whether this Cloud SQL instance should be assigned a public IPV4 address. At least `ipv4_enabled` must be enabled or a `private_network` must be configured. | `bool` | `false` | no |
| <a name="input_settings_ip_configuration_private_network"></a> [settings\_ip\_configuration\_private\_network](#input\_settings\_ip\_configuration\_private\_network) | The VPC network from which the Cloud SQL instance is accessible for private IP. For example, projects/myProject/global/networks/default. Specifying a network enables private IP. | `string` | `""` | no |
| <a name="input_settings_ip_configuration_ssl_mode"></a> [settings\_ip\_configuration\_ssl\_mode](#input\_settings\_ip\_configuration\_ssl\_mode) | (Optional) Specify how SSL connection should be enforced in DB connections. Supported values are `ALLOW_UNENCRYPTED_AND_ENCRYPTED`, `ENCRYPTED_ONLY`, `TRUSTED_CLIENT_CERTIFICATE_REQUIRED`. | `string` | `"ALLOW_UNENCRYPTED_AND_ENCRYPTED"` | no |
| <a name="input_settings_maintenance_window_day"></a> [settings\_maintenance\_window\_day](#input\_settings\_maintenance\_window\_day) | (Optional) The day of week (1-7) for maintenance window to start.Starting on Monday | `number` | `1` | no |
| <a name="input_settings_maintenance_window_hour"></a> [settings\_maintenance\_window\_hour](#input\_settings\_maintenance\_window\_hour) | (Optional) The hour of day (0-23) maintenance window starts.The maintenance window is specified in UTC time | `number` | `3` | no |
| <a name="input_settings_tier"></a> [settings\_tier](#input\_settings\_tier) | (Required) The machine type to use. See tiers for more details and supported versions. Postgres supports only shared-core machine types, and custom machine types | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_name"></a> [connection\_name](#output\_connection\_name) | The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy. |
| <a name="output_database_version"></a> [database\_version](#output\_database\_version) | Database version, such as MYSQL\_8\_0 or POSTGRES\_* |
| <a name="output_first_ip_address"></a> [first\_ip\_address](#output\_first\_ip\_address) | The IPv4 address assigned. |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy. |
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | The IPv4 address assigned. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The first private (`PRIVATE`) IPv4 address assigned. This is a workaround for an issue fixed in Terraform 0.12 but also provides a convenient way to access an IP of a specific type without performing filtering in a Terraform config. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The first public (`PRIMARY`) IPv4 address assigned. This is a workaround for an issue fixed in Terraform 0.12 but also provides a convenient way to access an IP of a specific type without performing filtering in a Terraform config. |
| <a name="output_read_replica_connection_name"></a> [read\_replica\_connection\_name](#output\_read\_replica\_connection\_name) | The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy. |
| <a name="output_read_replica_first_ip_address"></a> [read\_replica\_first\_ip\_address](#output\_read\_replica\_first\_ip\_address) | The IPv4 address assigned. |
| <a name="output_read_replica_instance_name"></a> [read\_replica\_instance\_name](#output\_read\_replica\_instance\_name) | The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy. |
| <a name="output_read_replica_ip_address"></a> [read\_replica\_ip\_address](#output\_read\_replica\_ip\_address) | The IPv4 address assigned. |
| <a name="output_read_replica_private_ip_address"></a> [read\_replica\_private\_ip\_address](#output\_read\_replica\_private\_ip\_address) | The first private (`PRIVATE`) IPv4 address assigned. This is a workaround for an issue fixed in Terraform 0.12 but also provides a convenient way to access an IP of a specific type without performing filtering in a Terraform config. |
| <a name="output_read_replica_public_ip_address"></a> [read\_replica\_public\_ip\_address](#output\_read\_replica\_public\_ip\_address) | The first public (`PRIMARY`) IPv4 address assigned. This is a workaround for an issue fixed in Terraform 0.12 but also provides a convenient way to access an IP of a specific type without performing filtering in a Terraform config. |
| <a name="output_read_replica_self_link"></a> [read\_replica\_self\_link](#output\_read\_replica\_self\_link) | The URI of the created resource. |
| <a name="output_read_replica_service_account_email_address"></a> [read\_replica\_service\_account\_email\_address](#output\_read\_replica\_service\_account\_email\_address) | The service account email address assigned to the instance. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The URI of the created resource. |
| <a name="output_service_account_email_address"></a> [service\_account\_email\_address](#output\_service\_account\_email\_address) | The service account email address assigned to the instance. |
<!-- END_TF_DOCS -->
