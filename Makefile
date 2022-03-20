lint:
	terraform fmt --recursive

validate: lint
	terraform init
	terraform validate

docs:
	terraform-docs -c .terraform-docs.yml .
	terraform-docs -c .terraform-docs-examples.yml .

commit: docs validate

apply_and_destroy:
	 terraform apply -auto-approve && terraform apply -auto-approve -destroy

test:
	cd test; go test -v -timeout 30m
