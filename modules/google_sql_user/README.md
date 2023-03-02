<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.55.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_user.users](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_host"></a> [host](#input\_host) | (Optional) The host the user can connect from. This is only supported for MySQL instances. Don't set this field for PostgreSQL instances. Can be an IP address. Changing this forces a new resource to be created. | `string` | `"localhost"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | (Required) The name of the Cloud SQL instance. This does not include the project ID | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the database in the Cloud SQL instance. This does not include the project ID or instance name. | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | (Required) The password for the user. Can be updated. For Postgres instances this is a Required field. | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | (Optional, default=`BUILT_IN`) The user type. It determines the method to authenticate the user during login. The default is the database's built-in user type. Flags include `BUILT_IN`, `CLOUD_IAM_USER`, or `CLOUD_IAM_SERVICE_ACCOUNT`. | `string` | `"BUILT_IN"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sql_password"></a> [sql\_password](#output\_sql\_password) | The password for the user |
| <a name="output_sql_user"></a> [sql\_user](#output\_sql\_user) | The name of the user. |
| <a name="output_user_type"></a> [user\_type](#output\_user\_type) | The user type |
<!-- END_TF_DOCS -->
