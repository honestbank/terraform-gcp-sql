lint:
	terraform fmt --recursive

validate: lint
	cd examples/create_mysql_instance_with_public_ip/; terraform init --upgrade; terraform validate
	cd examples/create_mysql_instance_with_private_ip/; terraform init --upgrade; terraform validate
	cd examples/mysql_instance_with_read_replica/; terraform init --upgrade; terraform validate
	cd examples/postgres_instance_with_read_replica/; terraform init --upgrade; terraform validate

docs:
	terraform-docs --lockfile=false -c .terraform-docs.yml .
	cd examples/create_mysql_instance_with_public_ip/; terraform-docs --lockfile=false markdown . --output-file README.md --output-mode inject
	cd examples/create_mysql_instance_with_private_ip/; terraform-docs --lockfile=false markdown . --output-file README.md --output-mode inject
	cd examples/mysql_instance_with_read_replica/; terraform-docs --lockfile=false markdown . --output-file README.md --output-mode inject
	cd examples/postgres_instance_with_read_replica/; terraform-docs --lockfile=false markdown . --output-file README.md --output-mode inject

commit: docs validate

apply_and_destroy:
	 terraform apply -auto-approve && terraform apply -auto-approve -destroy

tests:
	cd test; go clean -testcache; ./test.sh
