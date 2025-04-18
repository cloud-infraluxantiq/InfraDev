##############################################################
# Outputs: Django Cloud Run Deployment (Luxantiq)
# Useful for DNS mapping, CI/CD, IAM integration
##############################################################

# Public URL of the deployed Cloud Run service
output "cloud_run_url" {
  value       = google_cloud_run_service.django.status[0].url
  description = "The URL of the Django Cloud Run service"
}
