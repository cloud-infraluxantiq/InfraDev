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
# --------------------------
# IAM
# --------------------------
variable "iam_member" {
  description = "IAM member for Cloud Run invocation (e.g., serviceAccount:github-deployer@cloud-infra-dev.iam.gserviceaccount.com)"
  type        = string
}
# --------------------------
# JWT secret
# --------------------------
variable "secret_env_vars" {
  description = "Map of secret environment variables (key = ENV_VAR, value = Secret name)"
  type        = map(string)
}
variable "jwt_secret_secret" {
  description = "Secret Manager name for JWT secret"
  type        = string
  default     = "dev-jwt-secret"
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
# Reference to Secret Manager entry (already exists in tfvars or secrets)

variable "angular_secret_key_secret" {
  description = "Secret Manager name for Angular secret key (if applicable)"
  type        = string
}
# --------------------------
# Razor pay
# --------------------------
variable "razorpay_api_key_secret" {
  description = "Secret Manager name for Razorpay API Key"
  type        = string
}

variable "razorpay_api_secret_secret" {
  description = "Secret Manager name for Razorpay API Secret"
  type        = string
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
  default     = "e2-micro"  # or whatever you intend to use
}

variable "service_name" {
  type        = string
  description = "Cloud Run service name for Django"
}

variable "timeout_seconds" {
  type        = number
  description = "Timeout for Cloud Run service"
}
# --------------------------
# VPC
# --------------------------
variable "vpc_connector" {
  type        = string
  description = "Name of the VPC connector to attach"
}
variable "vpc_connector_cidr" {
  description = "CIDR range for the VPC Serverless connector"
  type        = string
}

variable "vpc_connector_region" {
  type        = string
  description = "Region to deploy VPC connector"
}
variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}
variable "private_network" {
  description = "The self-link of the VPC network to connect Cloud SQL"
  type        = string
}
variable "nat_region" {
  description = "Region used for Cloud NAT and Router"
  type        = string
}

# --------------------------
variable "memory_limit" {
  type        = string
  description = "Memory allocated for the container"
}

# Docker image URL for Django (used in cloud_run_django)
#variable "django_image_url" {
#  description = "Full image path for Django Cloud Run container"
# type        = string
#}
# Docker image URL for Angular (used in cloud_run_angular)
#variable "angular_image_url" {
#  description = "Docker image URL for Angular frontend"
#  type        = string
#}
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
# --------------------------
# FIrewall
# --------------------------

variable "firewall_rules" {
  description = "Map of firewall rule configurations"
  type        = map(object({
    description          = string
    direction            = string
    priority             = number
    ranges               = list(string)
    allow_protocol_ports = list(object({
      protocol = string
      ports    = list(string)
    }))
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
