variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project"
}

variable "region" {
  type        = string
  description = "The primary region for resources"
  default     = "asia-south1"
}

variable "project_number" {
  type        = string
  description = "The numeric ID of the project (used in IAM policies, bindings)"
}

variable "firebase_project_id" {
  type        = string
  description = "Firebase Project ID for Auth"
}

variable "firebase_auth_domain" {
  type        = string
  description = "Firebase Auth domain (e.g. your-app.firebaseapp.com)"
}

variable "firebase_api_key" {
  type        = string
  description = "Firebase Web API key"
}

variable "cloud_sql_instance_name" {
  type        = string
  default     = "luxantiq-dev-sql"
  description = "Name of the Cloud SQL instance"
}

variable "db_name" {
  type        = string
  default     = "dev_luxantiq"
  description = "PostgreSQL database name"
}

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
  description = "Secret Manager entry for JWT signing secret"
}

variable "django_secret_key_secret" {
  type        = string
  default     = "dev-django-secret-key"
  description = "Secret Manager entry for Django SECRET_KEY"
}

variable "gcs_service_key_secret" {
  type        = string
  default     = "dev-gcs-service-key"
  description = "Secret Manager entry for GCS service account base64 key"
}

variable "razorpay_api_key_secret" {
  type        = string
  default     = "dev-razorpay-api-key"
  description = "Secret Manager entry for Razorpay public key"
}

variable "razorpay_api_secret_secret" {
  type        = string
  default     = "dev-razorpay-api-secret"
  description = "Secret Manager entry for Razorpay private key"
}

variable "angular_domain" {
  type        = string
  default     = "shop.dev.angular.luxantiq.com"
  description = "Domain for the Angular frontend"
}

variable "django_domain" {
  type        = string
  default     = "api.dev.django.luxantiq.com"
  description = "Domain for the Django API backend"
}

variable "jenkins_domain" {
  type        = string
  default     = "jenkins.dev.luxantiq.com"
  description = "Domain for the Jenkins UI"
}

variable "cloud_run_django_service_name" {
  type        = string
  default     = "DjangoAPI"
  description = "Cloud Run service name for Django"
}

variable "cloud_run_angular_service_name" {
  type        = string
  default     = "AngularFrontend"
  description = "Cloud Run service name for Angular"
}

variable "state_bucket_name" {
  type        = string
  default     = "terraform-state-luxantiq-dev"
  description = "Name of the bucket storing Terraform state"
}

variable "enable_terraform_locking" {
  type        = bool
  default     = true
  description = "Enable Dynamo-style Terraform state locking"
}

variable "enable_scheduler" {
  type        = bool
  default     = true
  description = "Whether to provision Cloud Scheduler jobs"
}
