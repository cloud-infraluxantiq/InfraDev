############################################################
# Outputs: Luxantiq Secrets Module
# Returns IDs of key secrets and their versions
############################################################

# DB Password Secret ID
output "db_password_secret_id" {
  value = google_secret_manager_secret.db_password_secret.id
}

# JWT Secret ID
output "jwt_secret_id" {
  value = google_secret_manager_secret.jwt_secret_key.id
}

# Django SECRET_KEY Secret ID
output "django_secret_key_id" {
  value = google_secret_manager_secret.django_secret_key.id
}

# Firebase API Key Secret ID
output "firebase_api_key_id" {
  value = google_secret_manager_secret.firebase_api_key.id
}

# Razorpay API Key Secret ID
output "razorpay_api_key_id" {
  value = google_secret_manager_secret.razorpay_api_key.id
}

# GCS Service Key Secret ID
output "gcs_service_key_id" {
  value = google_secret_manager_secret.gcs_service_key.id
}
