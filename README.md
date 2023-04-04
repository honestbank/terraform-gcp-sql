# Terraform GCP SQL Module

This repository/module builds a [Google Cloud SQL](https://cloud.google.com/sql) instance and related resources.

This module is designed to be embedded into parent modules to be used to manage live infrastructure.

## Prerequisites

### Configure a Service Account

In order to execute this module you must have a Service Account with the following:

Role

- Cloud SQL Admin: `roles/cloudsql.admin`
- Compute Network Admin: `roles/compute.networkAdmin`

### Enable API

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Cloud SQL Admin API: `sqladmin.googleapis.com`

In order to use Private Service Access, required for using Private IPs, you must activate the following APIs on the project where your VPC resides:

- Cloud SQL Admin API: `sqladmin.googleapis.com`
- Compute Engine API: `compute.googleapis.com`
- Service Networking API: `servicenetworking.googleapis.com`
- Cloud Resource Manager API: `cloudresourcemanager.googleapis.com`

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
