
############################################################
# Outputs: SQL Postgres Module
# Exposes values for referencing in other modules or CI/CD
############################################################

# Cloud SQL instance name (used in Cloud Run / Secrets)
output "instance_name" {
  description = "Name of the Cloud SQL PostgreSQL instance"
  value       = google_sql_database_instance.postgres_instance.name
}

# Full connection name: project:region:instance (used in Django Cloud Run deploy)
output "connection_name" {
  description = "Cloud SQL connection string for Django (used by Cloud Run)"
  value       = google_sql_database_instance.postgres_instance.connection_name
}

# Private IP of the instance (used in VPC-based DB access)
output "private_ip_address" {
  description = "Primary private IP address of the Cloud SQL instance"
  value       = google_sql_database_instance.postgres_instance.ip_address[0].ip_address
}
