variable "network" {
  description = "(Required) Name of VPC network connected with service producers using VPC peering."
  type        = string
}

variable "service" {
  description = "(Required) Provider peering service that is managing peering connectivity for a service provider organization. For Google services that support this functionality it is 'servicenetworking.googleapis.com'."
  type        = string
  default     = "servicenetworking.googleapis.com"
}

variable "reserved_peering_ranges" {
  description = "(Required) Named IP address range(s) of PEERING type reserved for this service provider. Note that invoking this method with a different range when connection is already established will not reallocate already provisioned service producer subnetworks."
  type        = list(string)
}

variable "deletion_policy" {
  description = "(Optional) The deletion policy for the service networking connection. Setting to ABANDON allows the resource to be abandoned rather than deleted. This will enable a successful terraform destroy when destroying CloudSQL instances. Use with care as it can lead to dangling resources."
  type        = string
  default     = ""
}
