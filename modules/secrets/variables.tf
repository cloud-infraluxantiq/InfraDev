############################################################
# Input Variables: Luxantiq Secret Manager Module
# These secrets are securely injected into your services
############################################################

variable "project_id" {
  type        = string
  description = "Google Cloud project ID where secrets are stored"
}

# PostgreSQL DB Credentials
variable "db_password" {
  type        = string
  description = "The database password for Django (Secret Manager)"
}

variable "db_user" {
  type        = string
  description = "The database username for PostgreSQL"
}

# Django Auth Secrets
variable "jwt_secret" {
  type        = string
  description = "JWT signing key for user authentication in Django"
}

variable "django_secret_key" {
  type        = string
  description = "Django SECRET_KEY for cryptographic signing"
}

# Firebase Configuration Secrets
variable "firebase_api_key" {
  type        = string
  description = "Firebase Web API key"
}

variable "firebase_project_id" {
  type        = string
  description = "Firebase Project ID"
}

variable "firebase_auth_domain" {
  type        = string
  description = "Firebase Auth Domain"
}

# Razorpay Credentials
variable "razorpay_api_key" {
  type        = string
  description = "Razorpay public API key"
}

variable "razorpay_api_secret" {
  type        = string
  description = "Razorpay private secret key"
}

# Google Cloud Storage Service Key
variable "gcs_service_key" {
  type        = string
  description = "Base64-encoded GCS service account key (for media uploads)"
}
