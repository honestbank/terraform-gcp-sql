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
| [google_compute_global_address.default_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address"></a> [address](#input\_address) | (Optional) The IP address or beginning of the address range represented by this resource. This can be supplied as an input to reserve a specific address or omitted to allow GCP to choose a valid one for you. | `string` | `""` | no |
| <a name="input_address_type"></a> [address\_type](#input\_address\_type) | (Optional) The type of the address to reserve. `EXTERNAL` indicates public/external single IP address. `INTERNAL` indicates internal IP ranges belonging to some network. Default value is `EXTERNAL`. Possible values are `EXTERNAL` and `INTERNAL`. | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) An optional description of this resource. | `string` | `""` | no |
| <a name="input_ip_version"></a> [ip\_version](#input\_ip\_version) | (Optional) The IP Version that will be used by this address. The default value is `IPV4`. Possible values are `IPV4` and `IPV6` | `string` | `"IPV4"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the resource. Provided by the client when the resource is created. The name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression `[a-z]([-a-z0-9]*[a-z0-9])?` which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash. | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | (Optional) The URL of the network in which to reserve the IP range. The IP range must be in RFC1918 space. The network cannot be deleted if there are any reserved IP ranges referring to it. This should only be set when using an Internal address. | `string` | `""` | no |
| <a name="input_prefix_length"></a> [prefix\_length](#input\_prefix\_length) | (Optional) The prefix length of the IP range. If not present, it means the address field is a single IP address. This field is not applicable to addresses with `addressType=EXTERNAL`, or `addressType=INTERNAL` when `purpose=PRIVATE_SERVICE_CONNECT` | `string` | `""` | no |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | (Optional) The purpose of the resource. Possible values include: `VPC_PEERING` - for peer networks, `PRIVATE_SERVICE_CONNECT` - for (Beta only) Private Service Connect networks. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_creation_timestamp"></a> [creation\_timestamp](#output\_creation\_timestamp) | Creation timestamp in RFC3339 text format. |
| <a name="output_id"></a> [id](#output\_id) | an identifier for the resource with format `projects/{{project}}/global/addresses/{{name}}`. |
| <a name="output_name"></a> [name](#output\_name) | Name of the resource. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The URI of the created resource. |
<!-- END_TF_DOCS -->
