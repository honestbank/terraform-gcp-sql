# ######################################################################
# Creates a BigQuery connection that plugs the SQL read replica.
# Note: We also generate the SQL User in the read-only replica that will be used by the BigQuery connection  
######################################################################

resource "google_bigquery_connection" "connection" {
  provider      = google-beta
  connection_id = var.connection_id
  friendly_name = var.connection_id
  location      = var.location
  description   = var.description
  cloud_sql {
    instance_id = var.database_instance_id
    database    = var.database_name
    type        = "MYSQL"

    credential {
      username = var.sql_user_name
      password = var.sql_user_password
    }
  }
}
