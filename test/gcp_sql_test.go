package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestTerraformCreateGCPSQL(t *testing.T) {

	t.Run("create mysql with public ip", func(t *testing.T) {
		testDirectory := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/create_mysql_instance_with_public_ip")

		// retryable errors in terraform testing.
		terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: testDirectory,
			EnvVars:      map[string]string{"TF_LOG": os.Getenv("TF_LOG")},
		})

		defer terraform.Destroy(t, terraformOptions)

		terraform.InitAndApply(t, terraformOptions)

		var output string

		output = terraform.Output(t, terraformOptions, "random_string")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "test_terraform_sql_instance_name")
		assert.Contains(t, output, "sql-instance")

		output = terraform.Output(t, terraformOptions, "test_terraform_sql_self_link")
		assert.Contains(t, output, "sql-instance")

		output = terraform.Output(t, terraformOptions, "test_terraform_sql_service_account_email_address")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "test_terraform_sql_connection_name")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "test_sql_user_name")
		assert.Equal(t, output, "sql-user")

		output = terraform.Output(t, terraformOptions, "test_sql_database_1_id")
		assert.Contains(t, output, "db-first")

		output = terraform.Output(t, terraformOptions, "test_sql_database_2_id")
		assert.Contains(t, output, "db-second")
	})
}
