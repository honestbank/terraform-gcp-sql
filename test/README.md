# End-to-End Testing

This package uses [Terratest](https://terratest.gruntwork.io) for automatic/E2E
testing.

To run tests, first export the needed Terraform variables using the `TF_VAR` environment variable
syntax:

```shell
    ...
    export TF_VAR_<TERRAFORM_VARIABLE_NAME>="VALUE"
    ...
```

Then run the tests:

```bash
go test -v -timeout 150m
```

Tests should always be performed in a separate project (and a separate account,
if possible) to completely isolate live environments from any potential issues.
