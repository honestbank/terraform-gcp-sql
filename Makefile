lint:
	terraform fmt --recursive

validate: lint
	cd examples/create_mysql_instance_with_public_ip/; terraform init; terraform validate
	cd examples/create_mysql_instance_with_private_ip/; terraform init; terraform validate

docs:
	terraform-docs -c .terraform-docs.yml .
	cd examples/create_mysql_instance_with_public_ip/; terraform-docs markdown . --output-file README.md --output-mode inject
	cd examples/create_mysql_instance_with_private_ip/; terraform-docs markdown . --output-file README.md --output-mode inject

commit: docs validate

apply_and_destroy:
	 terraform apply -auto-approve && terraform apply -auto-approve -destroy

tests:
	cd test; go clean -testcache; go test -v -timeout 60m
