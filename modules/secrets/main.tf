############################################################
# Luxantiq Secrets Module - GCP Secret Manager
# Provisions secrets required by Django, Angular, Payments
############################################################
############################################################
# Luxantiq Secrets: READ EXISTING Secrets from GSM
############################################################

# Project ID
data "google_secret_manager_secret_version" "project_id" {
  secret  = var.project_id_secret
  project = var.project_id
}

# DB Password
data "google_secret_manager_secret_version" "db_password" {
  secret  = var.db_password_secret
  project = var.project_id
}

# DB Username
data "google_secret_manager_secret_version" "db_user" {
  secret  = var.db_user_secret
  project = var.project_id
}

# JWT Secret
data "google_secret_manager_secret_version" "jwt_secret" {
  secret  = var.jwt_secret_secret
  project = var.project_id
}

# Django SECRET_KEY
data "google_secret_manager_secret_version" "django_secret_key" {
  secret  = var.django_secret_key_secret
  project = var.project_id
}

# Razorpay API Key
data "google_secret_manager_secret_version" "razorpay_api_key" {
  secret  = var.razorpay_api_key_secret
  project = var.project_id
}

# Razorpay API Secret
data "google_secret_manager_secret_version" "razorpay_api_secret" {
  secret  = var.razorpay_api_secret_secret
  project = var.project_id
}

# Firebase API Key
data "google_secret_manager_secret_version" "firebase_api_key" {
  secret  = var.firebase_api_key
  project = var.project_id
}

# Firebase Project ID
data "google_secret_manager_secret_version" "firebase_project_id" {
  secret  = var.firebase_project_id
  project = var.project_id
}

# Firebase Auth Domain
data "google_secret_manager_secret_version" "firebase_auth_domain" {
  secret  = var.firebase_auth_domain
  project = var.project_id
}
