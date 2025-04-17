##############################################################
# Outputs: angular-frontend Cloud Run Deployment
# These outputs are useful for DNS, monitoring, CI/CD triggers
##############################################################

# Deployed Cloud Run URL (useful for testing or DNS redirection)
output "angular_app_url" {
  description = "The live URL of the deployed Angular frontend on Cloud Run"
  value       = google_cloud_run_service.angular_app.status[0].url
}

# The name of the deployed Cloud Run service
output "angular_service_name" {
  description = "Name of the Cloud Run Angular service"
  value       = google_cloud_run_service.angular_app.name
}

# Email identity of the Cloud Run service (can be used in IAM policies)
output "angular_service_identity" {
  description = "Identity (service account) used by Angular Cloud Run service"
  value       = google_cloud_run_service.angular_app.template[0].spec[0].service_account_name
}
