###############################################
# Luxantiq Terraform Infrastructure Variables
# Used across all modules
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
  default     = "asia-south1"
  description = "Primary region for all GCP resources"
}

variable "project_number" {
  type        = string
  description = "The numeric project ID (used in IAM bindings, policies)"
}

# -------------------------------
# Firebase Configuration
# -------------------------------
variable "firebase_project_id" {
  type        = string
  description = "Firebase Project ID"
}

variable "firebase_auth_domain" {
  type        = string
  description = "Firebase Auth domain"
}

variable "firebase_api_key" {
  type        = string
  description = "Firebase Web API key"
}

# -------------------------------
# Domain Configuration
# -------------------------------
variable "angular_domain" {
  type        = string
  default     = "shop.dev.angular.luxantiq.com"
  description = "Domain for the Angular frontend"
}

variable "django_domain" {
  type        = string
  default     = "api.dev.django.luxantiq.com"
  description = "Domain for the Django backend"
}

# -------------------------------
# Secret Manager Entries
# -------------------------------
variable "db_password" {
  type        = string
  description = "PostgreSQL DB password"
}

variable "db_user" {
  type        = string
  description = "PostgreSQL DB user"
}

variable "jwt_secret" {
  type        = string
  description = "JWT signing secret for Django"
}

variable "django_secret_key" {
  type        = string
  description = "Django SECRET_KEY"
}
variable "razorpay_api_key" {
  type        = string
  description = "Razorpay Public Key"
}

variable "razorpay_api_secret" {
  type        = string
  description = "Razorpay Secret Key"
}

# --------------------------
# Cloud Run Service Names
# --------------------------
variable "cloud_run_django_service_name" {
  type        = string
  default     = "django-api"
  description = "Cloud Run service name for Django"
}

variable "cloud_run_angular_service_name" {
  type        = string
  default     = "angular-frontend"
  description = "Cloud Run service name for Angular"
}

# --------------------------
# Load Balancer + DNS
# --------------------------
variable "dns_zone" {
  type        = string
  default     = "luxantiq-com-zone"
  description = "Cloud DNS zone name"
}

# --------------------------
# IAM: Service Accounts
# --------------------------
variable "service_accounts" {
  description = "Map of service accounts and their role assignments"
  type = map(object({
    display_name = string
    description  = string
    role         = string
    create_key   = bool
  }))
}

# --------------------------
# Terraform State Bucket
# --------------------------
variable "state_bucket_name" {
  type        = string
  default     = "terraform-state-luxantiq-dev"
  description = "GCS bucket for Terraform remote state"
}

# --------------------------
# Optional Feature Flags
# --------------------------
variable "enable_scheduler" {
  type        = bool
  default     = true
  description = "Whether to provision Cloud Scheduler jobs"
}
