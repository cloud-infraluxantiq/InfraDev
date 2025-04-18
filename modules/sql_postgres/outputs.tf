
############################################################
# Outputs: SQL Postgres Module
# Exposes values for referencing in other modules or CI/CD
############################################################

# Cloud SQL instance name (used in Cloud Run / Secrets)
output "connection_name" {
  value       = google_sql_database_instance.postgres_instance.connection_name
  description = "Connection string used by Cloud Run to connect to Cloud SQL"
}

output "instance_name" {
  value       = google_sql_database_instance.postgres_instance.name
  description = "Name of the Cloud SQL instance"
}
