#######################################################
# Luxantiq GCP Terraform Outputs
# This file exposes useful information after `apply`
# such as deployed URLs and IP addresses for services.
#######################################################

# -------------------------------
# Cloud Run Service Output URLs
# -------------------------------

# Django API endpoint (Cloud Run HTTPS URL)
output "django_api_url" {
  description = "URL of the deployed Django API service (secured by Firebase Auth)"
  value       = google_cloud_run_service.django_api.status[0].url
}

# Angular frontend public URL
output "angular_frontend_url" {
  description = "URL of the Angular frontend application on Cloud Run"
  value       = google_cloud_run_service.angular_frontend.status[0].url
}

# -------------------------------
# Jenkins & Load Balancer Outputs
# -------------------------------

# Global static IP used for Load Balancer/DNS records
output "load_balancer_ip" {
  description = "Global static IP address assigned to the HTTPS Load Balancer"
  value       = google_compute_global_address.lb_ip.address
}

# -------------------------------
# Cloud SQL / Networking Info
# -------------------------------

# Connection name used in Django database config
output "cloud_sql_connection_name" {
  description = "Cloud SQL connection string (used by Django to connect via private IP)"
  value       = google_sql_database_instance.postgres.connection_name
}

# Project ID (kept for scripting/debugging)
output "project_id" {
  description = "Google Cloud Project ID"
  value       = var.project_id
}
