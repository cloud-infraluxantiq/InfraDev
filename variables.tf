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
variable "concurrency" {
  description = "Concurrency value for Cloud Run service"
  type        = number
  default     = 80  # or remove default if you want to pass via GitHub secrets
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
variable "db_password_secret" {
  type        = string
  description = "Secret Manager name for PostgreSQL DB password"
}

variable "db_user" {
  type        = string
  default     = "postgres"
  description = "Database user name"
}
variable "jwt_secret" {
  type        = string
  description = "JWT signing secret for Django"
}

# Reference to Secret Manager entry (already exists in tfvars or secrets)
variable "django_secret_key_secret" {
  description = "Secret Manager name for Django SECRET_KEY"
  type        = string
}

variable "angular_secret_key_secret" {
  description = "Secret Manager name for Angular secret key (if applicable)"
  type        = string
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
variable "subnet" {
  description = "Subnet name or configuration"
  type        = string
}

variable "machine_type" {
  description = "VM instance machine type"
  type        = string
}

variable "service_name" {
  type        = string
  description = "Cloud Run service name for Django"
}

variable "image_url" {
  type        = string
  description = "Docker image URL for Django"
}

variable "timeout_seconds" {
  type        = number
  description = "Timeout for Cloud Run service"
}
variable "secret_env_vars" {
  type        = map(string)
  description = "Secrets to inject as environment variables"
}

variable "vpc_connector" {
  type        = string
  description = "Name of the VPC connector to attach"
}

variable "memory_limit" {
  type        = string
  description = "Memory allocated for the container"
}

# Docker image URL for Django (used in cloud_run_django)
variable "django_image_url" {
  description = "Docker image URL for Django backend"
  type        = string
}

# Docker image URL for Angular (used in cloud_run_angular)
variable "angular_image_url" {
  description = "Docker image URL for Angular frontend"
  type        = string
}
variable "db_name" {
  description = "Name of the PostgreSQL database"
  type        = string
}
variable "db_user_secret" {
  description = "Secret Manager name for DB username"
  type        = string
}

variable "django_secret_key_secret" {
  description = "Secret Manager name for Django secret key"
  type        = string
}

variable "iam_member" {
  description = "IAM member for Cloud Run invocation"
  type        = string
}
variable "nat_region" {
  description = "Region used for Cloud NAT and Router"
  type        = string
}

variable "private_network" {
  description = "VPC self-link for Cloud SQL private IP access"
  type        = string
}

variable "razorpay_api_key_secret" {
  description = "Secret Manager name for Razorpay API key"
  type        = string
}

variable "razorpay_api_secret_secret" {
  description = "Secret Manager name for Razorpay API secret"
  type        = string
}

variable "repo_name" {
  description = "Artifact Registry repository name"
  type        = string
}

variable "tier" {
  description = "Cloud SQL instance machine tier"
  type        = string
}

variable "url_map" {
  description = "URL map resource for Load Balancer SSL module"
  type        = string
}

variable "users" {
  description = "Map of PostgreSQL users and their passwords"
  type = map(object({
    password = string
  }))
}

variable "vpc_connector_cidr" {
  description = "CIDR range for the VPC Serverless connector"
  type        = string
}

variable "vpc_connector_region" {
  description = "Region where VPC connector will be created"
  type        = string
}

variable "vpc_name" {
  description = "Name of the custom VPC"
  type        = string
}

variable "firewall_rules" {
  description = "Map of firewall rule configurations"
  type = map(object({
    protocol      = string
    ports         = list(string)
    source_ranges = list(string)
    target_tags   = list(string)
    priority      = number
    description   = string
  }))
}

variable "databases" {
  description = "List of PostgreSQL database names to create"
  type        = list(string)
}

variable "database_flags" {
  description = "Database flags for Cloud SQL (e.g. for tuning)"
  type        = list(object({
    name  = string
    value = string
  }))
  default = []
}
