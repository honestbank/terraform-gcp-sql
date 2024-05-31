<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.0, < 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.0, < 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_service_networking_connection.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network"></a> [network](#input\_network) | (Required) Name of VPC network connected with service producers using VPC peering. | `string` | n/a | yes |
| <a name="input_reserved_peering_ranges"></a> [reserved\_peering\_ranges](#input\_reserved\_peering\_ranges) | (Required) Named IP address range(s) of PEERING type reserved for this service provider. Note that invoking this method with a different range when connection is already established will not reallocate already provisioned service producer subnetworks. | `list(string)` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | (Required) Provider peering service that is managing peering connectivity for a service provider organization. For Google services that support this functionality it is 'servicenetworking.googleapis.com'. | `string` | `"servicenetworking.googleapis.com"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peering"></a> [peering](#output\_peering) | (Computed) The name of the VPC Network Peering connection that was created by the service producer. |
<!-- END_TF_DOCS -->
