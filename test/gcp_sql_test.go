package test

import (
	_ "errors"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

const (
	maxRetries    = 3
	retryInterval = 10 * time.Second
)

// function retryTerraformDestroy attempts to destroy the Terraform configuration with 3 retries, returning the last encountered error if unsuccessful.
func retryTerraformDestroy(t *testing.T, terraformOptions *terraform.Options) error {
	var err error
	for i := 0; i < maxRetries; i++ {
		// Run terraform.DestroyE and check for nil indicating success
		_, err := terraform.DestroyE(t, terraformOptions)
		if err == nil {
			return nil // Success, no error
		}
		t.Logf("Retry %d/%d: Terraform destroy failed with error: %v", i+1, maxRetries, err)

		// Wait time before retrying
		time.Sleep(retryInterval)
	}
	return err // Return the last error encountered
}

func TestTerraformCreateGCPSQL(t *testing.T) {
	t.Parallel()

	t.Run("create mysql with read replica", func(t *testing.T) {
		t.Parallel()

		testDirectory := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/mysql_instance_with_read_replica")

		terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: testDirectory,
		})

		// Destroying terraform resources with 3 retries
		defer func() {
			err := retryTerraformDestroy(t, terraformOptions)
			if err != nil {
				t.Fatalf("Failed to destroy resources: %v", err)
			}
		}()

		// Apply the Terraform configuration
		_, err := terraform.InitAndApplyE(t, terraformOptions)
		assert.NoError(t, err, "Terraform apply failed")

		var output string

		output = terraform.Output(t, terraformOptions, "random_string")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_instance_name")
		assert.Contains(t, output, "sql-rr")

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_self_link")
		assert.Contains(t, output, "sql-rr")

		output = terraform.Output(t, terraformOptions, "sql_database_instance_read_replica_instance_name")
		assert.Contains(t, output, "sql-rr")
		assert.Contains(t, output, "-read-replica")

		output = terraform.Output(t, terraformOptions, "sql_database_instance_read_replica_self_link")
		assert.Contains(t, output, "sql-rr")
		assert.Contains(t, output, "-read-replica")

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_service_account_email_address")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_connection_name")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_user_name")
		assert.Equal(t, output, "sql-user")

		output = terraform.Output(t, terraformOptions, "sql_database_master_id")
		assert.Contains(t, output, "db-first")

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_public_ip_address")
		assert.Empty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_private_ip_address")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_database_instance_read_replica_public_ip_address")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_database_instance_read_replica_private_ip_address")
		assert.NotEmpty(t, output)
	})

	t.Run("create PostgreSQL with read replica", func(t *testing.T) {
		t.Parallel()

		testDirectory := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/postgres_instance_with_read_replica")

		terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: testDirectory,
		})

		// Destroying terraform resources with 3 retries
		defer func() {
			err := retryTerraformDestroy(t, terraformOptions)
			if err != nil {
				t.Fatalf("Failed to destroy resources: %v", err)
			}
		}()

		// Apply the Terraform configuration
		_, err := terraform.InitAndApplyE(t, terraformOptions)
		assert.NoError(t, err, "Terraform apply failed")

		var output string

		output = terraform.Output(t, terraformOptions, "random_string")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_instance_name")
		assert.Contains(t, output, "sql-rr")

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_self_link")
		assert.Contains(t, output, "sql-rr")

		output = terraform.Output(t, terraformOptions, "sql_database_instance_read_replica_instance_name")
		assert.Contains(t, output, "sql-rr")
		assert.Contains(t, output, "-read-replica")

		output = terraform.Output(t, terraformOptions, "sql_database_instance_read_replica_self_link")
		assert.Contains(t, output, "sql-rr")
		assert.Contains(t, output, "-read-replica")

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_service_account_email_address")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_connection_name")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_user_name")
		assert.Equal(t, output, "sql-user")

		output = terraform.Output(t, terraformOptions, "sql_database_master_id")
		assert.Contains(t, output, "db-first")

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_public_ip_address")
		assert.Empty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_database_instance_master_private_ip_address")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_database_instance_read_replica_public_ip_address")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "sql_database_instance_read_replica_private_ip_address")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "database_version")
		assert.True(t, strings.HasPrefix(output, "POSTGRES_"))
	})
}
