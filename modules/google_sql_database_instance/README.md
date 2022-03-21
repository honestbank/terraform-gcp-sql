<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.12.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_database_instance.instance](https://registry.terraform.io/providers/hashicorp/google/4.12.0/docs/resources/sql_database_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | (Required) The MySQL or PostgreSQL version to use. Supported values include `MYSQL_5_6`, `MYSQL_5_7`, `MYSQL_8_0`, `POSTGRES_9_6`,`POSTGRES_10`, `POSTGRES_11`, `POSTGRES_12`, `POSTGRES_13` | `string` | `"MYSQL_8_0"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | (Optional, Default: `true` ) Whether or not to allow Terraform to destroy the instance. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply command that deletes the instance will fail. | `bool` | `true` | no |
| <a name="input_master_instance_name"></a> [master\_instance\_name](#input\_master\_instance\_name) | (Optional) The name of the existing instance that will act as the master in the replication setup. Note, this requires the master to have `binary_log_enabled` set, as well as existing backups. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional, Computed) The name of the instance. If the name is left blank, Terraform will randomly generate one when the instance is first created. This is done because after a name is used, it cannot be reused for up to one week. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region the instance will sit in | `string` | `""` | no |
| <a name="input_settings_availability_type"></a> [settings\_availability\_type](#input\_settings\_availability\_type) | (Optional, Default: `ZONAL`) The availability type of the Cloud SQL instance, high availability (`REGIONAL`) or single zone (`ZONAL`) | `string` | `"ZONAL"` | no |
| <a name="input_settings_backup_configuration_binary_log_enabled"></a> [settings\_backup\_configuration\_binary\_log\_enabled](#input\_settings\_backup\_configuration\_binary\_log\_enabled) | (Optional) True if binary logging is enabled. Cannot be used with Postgres. | `bool` | `true` | no |
| <a name="input_settings_backup_configuration_enabled"></a> [settings\_backup\_configuration\_enabled](#input\_settings\_backup\_configuration\_enabled) | (Optional) True if backup configuration is enabled. | `bool` | `true` | no |
| <a name="input_settings_disk_autoresize"></a> [settings\_disk\_autoresize](#input\_settings\_disk\_autoresize) | (Optional, Default: `true`) Configuration to increase storage size automatically. Note that future `terraform apply` calls will attempt to resize the disk to the value specified in `disk_size` - if this is set, do not set `disk_size`. | `bool` | `true` | no |
| <a name="input_settings_disk_autoresize_limit"></a> [settings\_disk\_autoresize\_limit](#input\_settings\_disk\_autoresize\_limit) | (Optional, Default: `0`) The maximum size, in GB, to which storage capacity can be automatically increased. The default value is `0`, which specifies that there is no limit. | `number` | `0` | no |
| <a name="input_settings_disk_size"></a> [settings\_disk\_size](#input\_settings\_disk\_size) | (Optional, Default: `10`) The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased. | `number` | `10` | no |
| <a name="input_settings_disk_type"></a> [settings\_disk\_type](#input\_settings\_disk\_type) | (Optional, Default: `PD_SSD`) The type of data disk: `PD_SSD` or `PD_HDD`. | `string` | `"PD_SSD"` | no |
| <a name="input_settings_ip_configuration_ipv4_enabled"></a> [settings\_ip\_configuration\_ipv4\_enabled](#input\_settings\_ip\_configuration\_ipv4\_enabled) | Whether this Cloud SQL instance should be assigned a public IPV4 address. At least `ipv4_enabled` must be enabled or a `private_network` must be configured. | `bool` | `false` | no |
| <a name="input_settings_ip_configuration_private_network"></a> [settings\_ip\_configuration\_private\_network](#input\_settings\_ip\_configuration\_private\_network) | The VPC network from which the Cloud SQL instance is accessible for private IP. For example, projects/myProject/global/networks/default. Specifying a network enables private IP. | `string` | `""` | no |
| <a name="input_settings_ip_configuration_require_ssl"></a> [settings\_ip\_configuration\_require\_ssl](#input\_settings\_ip\_configuration\_require\_ssl) | (Optional) Whether SSL connections over IP are enforced or not. | `bool` | `true` | no |
| <a name="input_settings_tier"></a> [settings\_tier](#input\_settings\_tier) | (Required) The machine type to use. See tiers for more details and supported versions. Postgres supports only shared-core machine types, and custom machine types | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_name"></a> [connection\_name](#output\_connection\_name) | The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy. |
| <a name="output_first_ip_address"></a> [first\_ip\_address](#output\_first\_ip\_address) | The IPv4 address assigned. |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The URI of the created resource. |
| <a name="output_service_account_email_address"></a> [service\_account\_email\_address](#output\_service\_account\_email\_address) | The service account email address assigned to the instance. |
<!-- END_TF_DOCS -->
