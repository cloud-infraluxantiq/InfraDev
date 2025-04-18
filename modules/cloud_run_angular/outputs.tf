##############################################################
# Outputs: angular-frontend Cloud Run Deployment
# These outputs are useful for DNS, monitoring, CI/CD triggers
##############################################################

output "cloud_run_url" {
  value       = google_cloud_run_service.angular_app.status[0].url
  description = "The URL of the Angular Cloud Run service"
}
