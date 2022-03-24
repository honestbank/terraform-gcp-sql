package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestTerraformCreateGCPSQL(t *testing.T) {
	t.Parallel()

	t.Run("test basic google sql instance database", func(t *testing.T) {
		t.Parallel()

		testDirectory := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/test-terratest")

		// retryable errors in terraform testing.
		terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: testDirectory,
			EnvVars:      map[string]string{"TF_LOG": os.Getenv("TF_LOG")},
		})

		defer terraform.Destroy(t, terraformOptions)

		terraform.InitAndApply(t, terraformOptions)

		var output string

		output = terraform.Output(t, terraformOptions, "instance_suffix")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_instance_name")
		assert.Contains(t, output, "main-instance-")
	})

	//t.Run("create mysql with public ip", func(t *testing.T) {
	//	t.Parallel()
	//
	//	testDirectory := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/create_mysql_instance_with_public_ip")
	//
	//	// retryable errors in terraform testing.
	//	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
	//		TerraformDir: testDirectory,
	//		EnvVars:      map[string]string{"TF_LOG": os.Getenv("TF_LOG")},
	//	})
	//
	//	defer terraform.Destroy(t, terraformOptions)
	//
	//	terraform.InitAndApply(t, terraformOptions)
	//
	//	var output string
	//
	//	output = terraform.Output(t, terraformOptions, "random_string")
	//	assert.NotEmpty(t, output)
	//
	//	output = terraform.Output(t, terraformOptions, "test_terraform_sql_instance_name")
	//	assert.Contains(t, output, "sql-public")
	//
	//	output = terraform.Output(t, terraformOptions, "test_terraform_sql_self_link")
	//	assert.Contains(t, output, "sql-public")
	//
	//	output = terraform.Output(t, terraformOptions, "test_terraform_sql_service_account_email_address")
	//	assert.NotEmpty(t, output)
	//
	//	output = terraform.Output(t, terraformOptions, "test_terraform_sql_connection_name")
	//	assert.NotEmpty(t, output)
	//
	//	output = terraform.Output(t, terraformOptions, "sql_user_name")
	//	assert.Equal(t, output, "sql-user")
	//
	//	output = terraform.Output(t, terraformOptions, "test_sql_database_1_id")
	//	assert.Contains(t, output, "db-first")
	//
	//	output = terraform.Output(t, terraformOptions, "test_sql_database_2_id")
	//	assert.Contains(t, output, "db-second")
	//
	//	output = terraform.Output(t, terraformOptions, "test_sql_database_instance_private_ip_public_ip_address")
	//	assert.NotEmpty(t, output)
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_master_private_ip_address")
	//	assert.Empty(t, output)
	//})
	//
	//t.Run("create mysql with private ip", func(t *testing.T) {
	//	t.Parallel()
	//
	//	testDirectory := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/create_mysql_instance_with_private_ip")
	//
	//	// retryable errors in terraform testing.
	//	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
	//		TerraformDir: testDirectory,
	//		EnvVars:      map[string]string{"TF_LOG": os.Getenv("TF_LOG")},
	//	})
	//
	//	defer terraform.Destroy(t, terraformOptions)
	//
	//	terraform.InitAndApply(t, terraformOptions)
	//
	//	var output string
	//
	//	output = terraform.Output(t, terraformOptions, "random_string")
	//	assert.NotEmpty(t, output)
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_master_instance_name")
	//	assert.Contains(t, output, "sql-private")
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_master_self_link")
	//	assert.Contains(t, output, "sql-private")
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_master_service_account_email_address")
	//	assert.NotEmpty(t, output)
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_master_connection_name")
	//	assert.NotEmpty(t, output)
	//
	//	output = terraform.Output(t, terraformOptions, "sql_user_name")
	//	assert.Equal(t, output, "sql-user")
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_master_id")
	//	assert.Contains(t, output, "db-first")
	//
	//	output = terraform.Output(t, terraformOptions, "test_sql_database_instance_private_ip_public_ip_address")
	//	assert.Empty(t, output)
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_master_private_ip_address")
	//	assert.NotEmpty(t, output)
	//})
	//
	//t.Run("create mysql with read replica", func(t *testing.T) {
	//	t.Parallel()
	//
	//	testDirectory := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/mysql_instance_with_read_replica")
	//
	//	// retryable errors in terraform testing.
	//	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
	//		TerraformDir: testDirectory,
	//		EnvVars:      map[string]string{"TF_LOG": os.Getenv("TF_LOG")},
	//	})
	//
	//	defer terraform.Destroy(t, terraformOptions)
	//
	//	terraform.InitAndApply(t, terraformOptions)
	//
	//	var output string
	//
	//	output = terraform.Output(t, terraformOptions, "random_string")
	//	assert.NotEmpty(t, output)
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_master_instance_name")
	//	assert.Contains(t, output, "sql-rr")
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_master_self_link")
	//	assert.Contains(t, output, "sql-rr")
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_read_replica_instance_name")
	//	assert.Contains(t, output, "sql-rr")
	//	assert.Contains(t, output, "-read-replica")
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_read_replica_self_link")
	//	assert.Contains(t, output, "sql-rr")
	//	assert.Contains(t, output, "-read-replica")
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_master_service_account_email_address")
	//	assert.NotEmpty(t, output)
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_master_connection_name")
	//	assert.NotEmpty(t, output)
	//
	//	output = terraform.Output(t, terraformOptions, "sql_user_name")
	//	assert.Equal(t, output, "sql-user")
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_master_id")
	//	assert.Contains(t, output, "db-first")
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_read_replica_public_ip_address")
	//	assert.NotEmpty(t, output)
	//
	//	output = terraform.Output(t, terraformOptions, "sql_database_instance_read_replica_private_ip_address")
	//	assert.NotEmpty(t, output)
	//})
}
