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
| [google_compute_network.vpc_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_create_subnetworks"></a> [auto\_create\_subnetworks](#input\_auto\_create\_subnetworks) | (Optional) When set to `true`, the network is created in `auto subnet mode` and it will create a subnet for each region automatically across the `10.128.0.0/9` address range. When set to `false`, the network is created in `custom subnet mode` so the user can explicitly connect subnetwork resources. | `string` | `""` | no |
| <a name="input_delete_default_routes_on_create"></a> [delete\_default\_routes\_on\_create](#input\_delete\_default\_routes\_on\_create) | (Optional) If set to `true`, default routes (`0.0.0.0/0`) will be deleted immediately after network creation. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) An optional description of this resource. The resource must be recreated to modify this field. | `string` | `""` | no |
| <a name="input_mtu"></a> [mtu](#input\_mtu) | (Optional) Maximum Transmission Unit in bytes. The minimum value for this field is 1460 and the maximum value is 1500 bytes | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the resource. Provided by the client when the resource is created. The name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression `[a-z]([-a-z0-9]*[a-z0-9])?` which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash. | `string` | n/a | yes |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | (Optional) The network-wide routing mode to use. If set to `REGIONAL`, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to `GLOBAL`, this network's cloud routers will advertise routes with all subnetworks of this network, across regions. Possible values are `REGIONAL` and `GLOBAL` | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gateway_ipv4"></a> [gateway\_ipv4](#output\_gateway\_ipv4) | The gateway address for default routing out of the network. This value is selected by GCP. |
| <a name="output_id"></a> [id](#output\_id) | an identifier for the resource with format `projects/{{project}}/global/networks/{{name}}`. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The URI of the created resource. |
<!-- END_TF_DOCS -->
