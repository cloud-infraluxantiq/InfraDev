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
  value       = module.cloud_run_django.cloud_run_url
  description = "URL of the deployed Django API"
}

output "angular_frontend_url" {
  value       = module.cloud_run_angular.cloud_run_url
  description = "URL of the deployed Angular frontend"
}

# -------------------------------
# Jenkins & Load Balancer Outputs
# -------------------------------

output "load_balancer_ip" {
  value       = module.lb.lb_ip_address
  description = "Global IP of Load Balancer"
}

# -------------------------------
# Cloud SQL / Networking Info
# -------------------------------

output "cloud_sql_connection_name" {
  value       = module.sql_postgres.connection_name
  description = "Cloud SQL connection string"
}
