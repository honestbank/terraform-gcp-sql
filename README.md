# Terraform Layer Module Template Repository

Use this repository as a starting point for building a [Terraform Component Module](https://www.notion.so/honestbank/WIP-How-to-structure-a-Terraform-module-31374a1594f84ef7b185ef4e06b36619).

The recommended usage is to make this a public trunk-based development repo that automatically releases using SemVer on
merge to trunk (typically called `main`). This module is then embedded and instantiated by Layer Modules to manage live
infrastructure.

## Prerequisite

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

## Customizations

### Pre-commit

This template contains a [.pre-commit-config.yaml file](./.pre-commit-config.yaml). To use this, please [install pre-commit](https://pre-commit.com/#install)
and run `pre-commit install` to install hooks. The default set of hooks should work for most Terraform modules/repos - please
customize as needed.

### Releases

This template contains a [semantic-release](https://github.com/semantic-release/semantic-release) [configuration file](./release.config.js)
that is configured to produce releases on merge to `main`.

### GitHub Actions

This template contains [a 'terraform' action/workflow](./.github/workflows/terraform.yml) that is configured to run on
PRs and pushes to four branches:

* test
* dev
* qa
* prod

It expects a set of Terraform Cloud workspaces ending in the branch name (eg. `infra-test`, `infra-dev`, `infra-qa`, `infra-prod`).
For single-branch workspaces/repos (for example, if you only have a `prod` branch), update/edit the [terraform.yml workflow file](./.github/workflows/terraform.yml).

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
