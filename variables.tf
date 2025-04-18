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

variable "concurrency" {
  description = "Concurrency value for Cloud Run service"
  type        = number
  default     = 80  # or remove default if you want to pass via GitHub secrets
}
variable "cloud_sql_instance_name" {
  type        = string
  description = "Cloud SQL instance name"
}

variable "angular_image_url" {
  type        = string
  description = "Image URL for Angular frontend"
}
variable "django_image_url" {
  type        = string
  description = "Docker image URL for Django"
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
variable "domain_names" {
  description = "List of domains used in managed SSL certs"
  type        = list(string)
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
variable "project_number_secret" {
  type        = string
  description = "Secret Manager name for GCP project number"
}

variable "project_id_secret" {
  type        = string
  description = "Secret Manager name for GCP project ID"
}

variable "service_account_email_secret" {
  type        = string
  description = "Secret Manager name for the GCP service account email"
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
  description = "luxantiq-com-zone"
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
# Optional Feature Flags
# --------------------------
variable "enable_scheduler" {
  type        = bool
  default     = true
  description = "Whether to provision Cloud Scheduler jobs"
}
variable "subnet" {
  description = "Subnet name or configuration for VM"
  type        = string
}
variable "machine_type" {
  description = "VM instance machine type"
  type        = string
  default     = "e2-micro"  # or whatever you intend to use
}

variable "timeout_seconds" {
  type        = number
  description = "Timeout for Cloud Run service"
}
# --------------------------
# VPC
# --------------------------
variable "vpc_name" {
  type = string
}

variable "vpc_connector_cidr" {
  type = string
}
variable "vpc_connector" {
  type        = string
  description = "Name of the VPC connector to attach"
}
variable "vpc_connector_region" {
  type        = string
  description = "Region to deploy VPC connector"
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
# FIrewall
# --------------------------

variable "firewall_rules" {
  description = "Map of firewall rules with advanced protocol support"
  type = map(object({
    description          = string
    direction            = string
    priority             = number
    ranges               = list(string)
    allow_protocol_ports = list(object({
      protocol = string
      ports    = list(string)
    }))
    target_tags = list(string)
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

# --------------------------
variable "memory_limit" {
  type        = string
  description = "Memory allocated for the container"
}
# --------------------------
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

variable "users" {
  description = "Map of PostgreSQL users and their passwords"
  type = map(object({
    password = string
  }))
}
# --------------------------
# Disk size 
# --------------------------

variable "disk_size" {
  type        = number
  description = "Disk size for the Cloud SQL instance"
}
# ----------------------------
# Added for VPC compatibility
# ----------------------------
variable "subnets" {
  description = "Map of subnets with CIDR, region, and optional secondary ranges"
  type = map(object({
    cidr             = string
    region           = string
    secondary_ranges = map(string)
  }))
}


variable "encryption_key_name" {
  type        = string
  description = "KMS key for SQL instance encryption"
}

variable "service_account_email" {
  type        = string
  description = "Service account to use for SQL or other services"
}
