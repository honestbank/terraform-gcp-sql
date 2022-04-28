resource "random_id" "instance_suffix" {
  byte_length = 4
}

resource "random_id" "random_string" {
  byte_length = 12
}

module "google_compute_network_private_network" {
  source = "../../modules/google_compute_network"

  name = "private-network-${random_id.instance_suffix.hex}"
}

module "google_compute_global_address_private_ip" {
  source = "../../modules/google_compute_global_address"

  name          = "private-ip-address-${random_id.instance_suffix.hex}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.google_compute_network_private_network.id
}

module "google_service_networking_connection_private_vpc_connection" {
  source = "../../modules/google_service_networking_connection"

  network                 = module.google_compute_network_private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [module.google_compute_global_address_private_ip.name]
}

module "sql_database_instance" {
  source = "../../modules/google_sql_database_instance"

  name = "sql-rr-${random_id.instance_suffix.hex}"
  #checkov:skip=CKV_GCP_79:Ensure SQL database is using latest Major version"
  database_version = "MYSQL_8_0"

  depends_on = [module.google_service_networking_connection_private_vpc_connection]


  settings_backup_configuration_binary_log_enabled = var.settings_backup_configuration_binary_log_enabled
  settings_backup_configuration_enabled            = var.settings_backup_configuration_enabled

  # Requirements for using the Cloud SQL Auth proxy
  # https://cloud.google.com/sql/docs/mysql/sql-proxy#requirements

  settings_ip_configuration_ipv4_enabled    = true
  settings_ip_configuration_private_network = module.google_compute_network_private_network.id

  #checkov:skip=CKV_GCP_6:Ensure all Cloud SQL database instance requires all incoming connections to use SSL"
  settings_ip_configuration_require_ssl = false

  settings_availability_type = var.settings_availability_type

  settings_tier       = var.settings_tier
  deletion_protection = false

  enable_read_replica                                 = false
  read_replica_settings_ip_configuration_ipv4_enabled = true
  read_replica_settings_tier                          = var.settings_tier
}

module "sql_database" {
  source = "../../modules/google_sql_database"

  depends_on = [
    module.sql_user
  ]

  instance_name = module.sql_database_instance.instance_name
  name          = var.database_name
}

module "sql_user" {
  source = "../../modules/google_sql_user"

  depends_on = [
    module.sql_database_instance
  ]

  instance_name = module.sql_database_instance.instance_name
  name          = var.user_name
  password      = random_id.random_string.hex
  host          = "%"
  type          = var.user_type
}

resource "local_sensitive_file" "google_credentials" {
  filename        = "credentials.json"
  file_permission = "0600"
  content         = var.google_credentials
}

resource "local_file" "combined_sql" {
  filename        = "combined.sql"
  file_permission = "0600"
  content         = <<EOF
SELECT (CASE
            WHEN id <> (SELECT MIN(id)
                        FROM audit_log_rules
                        WHERE CONCAT(`username`, `dbname`, `object`, `operation`, `op_result`) = '****B'
                        ORDER BY id) THEN CONCAT("CALL mysql.cloudsql_delete_audit_rule('", id, "',1,@outval,@outmsg);")
            ELSE ""
    END) AS `result`
FROM audit_log_rules

HAVING `result` <> ""

UNION

SELECT (CASE
            WHEN count = 0 THEN "CALL mysql.cloudsql_create_audit_rule('*', '*', '*', '*', 'B', 1, @outval, @outmsg);"
            ELSE ""
    END) as `result`
FROM (SELECT COUNT(1) AS COUNT
      FROM `audit_log_rules`
      WHERE CONCAT(`username`, `dbname`, `object`, `operation`, `op_result`) = '****B') as rule_count

HAVING `result` <> "";
EOF

}

resource "local_sensitive_file" "enable_audit_log" {
  filename        = "enable-audit-log.sh"
  file_permission = "0755"
  content         = <<EOF
#!/bin/bash
mysql-client/bin/mysql -h 127.0.0.1 -P 33069 -u ${module.sql_user.sql_user} -p${random_id.random_string.hex} mysql < combined.sql | grep "CALL" > rules.sql
mysql-client/bin/mysql -h 127.0.0.1 -P 33069 -u ${module.sql_user.sql_user} -p${random_id.random_string.hex} mysql < rules.sql
EOF
}

resource "null_resource" "run-enable-database-audit-log" {
  count = 1

  triggers = {
    always_run = timestamp()
  }

  depends_on = [
    local_sensitive_file.google_credentials,
    local_file.combined_sql,
    local_sensitive_file.enable_audit_log,
    module.sql_database
  ]

  provisioner "local-exec" {
    command = <<EOF
curl -o mysql-client.tar.xz ${var.mysql_client_url}
tar -xf mysql-client.tar.xz
mv mysql*-minimal mysql-client
mysql-client/bin/mysql --version
EOF
  }

  provisioner "local-exec" {
    command = <<EOF
curl -o cloud_sql_proxy ${var.cloud_sql_proxy_url}
chmod +x cloud_sql_proxy
EOF
  }

  provisioner "local-exec" {
    command = <<EOF
echo ${local_sensitive_file.enable_audit_log.content} > enable-audit-log2.sh
chmod +x enable-audit-log2.sh
EOF
  }

  provisioner "local-exec" {
    command = <<EOF
echo "enable-audit-log.sh"
cat enable-audit-log.sh
echo "enable-audit-log2.sh"
cat enable-audit-log2.sh
EOF
  }

  provisioner "local-exec" {
    command = <<EOF
nohup ./cloud_sql_proxy -dir /tmp -credential_file=${local_sensitive_file.google_credentials.filename} -instances=${var.google_project}:${var.google_region}:${module.sql_database_instance.instance_name}=tcp:0.0.0.0:33069 &
serverPID=$!
echo "cloud_sql_proxy: $serverPID"
sleep 5
apk add mysql-client
echo "enable-audit-log.sh"
./enable-audit-log.sh
echo "enable-audit-log2.sh"
./enable-audit-log2.sh
kill $serverPID
EOF
  }
}
