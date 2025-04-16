###############################################
# Luxantiq Terraform Infrastructure Variables
# These variables are referenced across all modules
# and represent secrets, resource names, and domains.
###############################################

# --------------------------
# Core Project Configuration
# --------------------------
variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project"
}

variable "region" {
  type        = string
  description = "Primary region for all GCP resources"
  default     = "asia-south1"
}

variable "project_number" {
  type        = string
  description = "The numeric project ID (used in IAM bindings, policies)"
}

# -------------------------------
# Firebase Authentication Config
# -------------------------------
variable "firebase_project_id" {
  type        = string
  description = "Firebase Project ID (used in frontend & auth bindings)"
}

variable "firebase_auth_domain" {
  type        = string
  description = "Firebase Auth domain (e.g., your-app.firebaseapp.com)"
}

variable "firebase_api_key" {
  type        = string
  description = "Firebase Web API key"
}

# -------------------------------
# Cloud SQL Configuration (Postgres)
# -------------------------------
variable "cloud_sql_instance_name" {
  type        = string
  default     = "luxantiq-dev-sql"
  description = "Cloud SQL instance name"
}

variable "db_name" {
  type        = string
  default     = "dev_luxantiq"
  description = "PostgreSQL DB name"
}

# ------------------------
# Secret Manager References
# ------------------------
variable "db_user_secret" {
  type        = string
  default     = "dev-db-user"
  description = "Secret Manager entry for DB username"
}

variable "db_password_secret" {
  type        = string
  default     = "dev-db-password"
  description = "Secret Manager entry for DB password"
}

variable "jwt_secret_secret" {
  type        = string
  default     = "dev-jwt-secret"
  description = "JWT signing secret for Django (from Secret Manager)"
}

variable "django_secret_key_secret" {
  type        = string
  default     = "dev-django-secret-key"
  description = "Django SECRET_KEY (from Secret Manager)"
}

variable "gcs_service_key_secret" {
  type        = string
  default     = "dev-gcs-service-key"
  description = "Base64-encoded GCS service account key"
}

variable "service_accounts" {
  description = "Map of service accounts and their role assignments"
  type = map(object({
    display_name = string
    description  = string
    role         = string
    create_key   = bool
  }))
}


variable "razorpay_api_key_secret" {
  type        = string
  default     = "dev-razorpay-api-key"
  description = "Razorpay public API key (from Secret Manager)"
}

variable "razorpay_api_secret_secret" {
  type        = string
  default     = "dev-razorpay-api-secret"
  description = "Razorpay private key/secret"
}

# -------------------------------
# Domain Names (Frontend/Backend)
# -------------------------------
variable "angular_domain" {
  type        = string
  default     = "shop.dev.angular.luxantiq.com"
  description = "Domain for the Angular frontend (Cloud Run)"
}

variable "django_domain" {
  type        = string
  default     = "api.dev.django.luxantiq.com"
  description = "Domain for the Django API backend"
}

variable "jenkins_domain" {
  type        = string
  default     = "jenkins.dev.luxantiq.com"
  description = "Domain mapped to Jenkins on GCE"
}

# --------------------------
# Cloud Run Service Names
# --------------------------
variable "cloud_run_django_service_name" {
  type        = string
  default     = "DjangoAPI"
  description = "Cloud Run service name for Django API"
}

variable "cloud_run_angular_service_name" {
  type        = string
  default     = "AngularFrontend"
  description = "Cloud Run service name for Angular frontend"
}

# --------------------------
# Terraform State Management
# --------------------------
variable "state_bucket_name" {
  type        = string
  default     = "terraform-state-luxantiq-dev"
  description = "GCS bucket name for storing Terraform state"
}

variable "enable_terraform_locking" {
  type        = bool
  default     = true
  description = "Enable bucket-level locking for Terraform state"
}

# --------------------------
# Optional Feature Flags
# --------------------------
variable "enable_scheduler" {
  type        = bool
  default     = true
  description = "Enable Cloud Scheduler + Pub/Sub for automation"
}
