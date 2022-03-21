lint:
	terraform fmt --recursive

validate: lint
	terraform init
	terraform validate

docs:
	terraform-docs -c .terraform-docs.yml .
	cd example/; terraform-docs markdown . --output-file README.md --output-mode inject

commit: docs validate

apply_and_destroy:
	 terraform apply -auto-approve && terraform apply -auto-approve -destroy

test:
	cd test; go test -v -timeout 30m
