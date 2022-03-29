<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_database.database](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_charset"></a> [charset](#input\_charset) | (Optional) The charset value. See MySQL's Supported Character Sets and Collations and Postgres' Character Set Support for more details and supported values. Postgres databases only support a value of UTF8 at creation time. | `string` | `""` | no |
| <a name="input_collation"></a> [collation](#input\_collation) | (Optional) The collation value. See MySQL's Supported Character Sets and Collations and Postgres' Collation Support for more details and supported values. Postgres databases only support a value of en\_US.UTF8 at creation time. | `string` | `""` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | (Required) The name of the Cloud SQL instance. This does not include the project ID | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the database in the Cloud SQL instance. This does not include the project ID or instance name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | an identifier for the resource with format projects/{{project}}/instances/{{instance}}/databases/{{name}} |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The URI of the created resource. |
<!-- END_TF_DOCS -->
