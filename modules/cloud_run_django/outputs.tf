##############################################################
# Outputs: Django Cloud Run Deployment (Luxantiq)
# Useful for DNS mapping, CI/CD, IAM integration
##############################################################

# ✅ Public URL of the deployed Cloud Run service
output "django_api_url" {
  description = "Live URL of the deployed Django API on Cloud Run"
  value       = google_cloud_run_service.django.status[0].url
}

# ✅ Name of the Cloud Run service
output "django_service_name" {
  description = "Name of the deployed Django Cloud Run service"
  value       = google_cloud_run_service.django.name
}

# ✅ Optional: service identity used by Cloud Run
output "django_service_identity" {
  description = "Service account identity used by Django Cloud Run (useful for IAM roles)"
  value       = google_cloud_run_service.django.template[0].spec[0].service_account_name
}

