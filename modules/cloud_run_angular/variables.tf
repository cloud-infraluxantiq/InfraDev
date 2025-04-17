############################################
# Input Variables: angular-frontend Run Module
# These values configure the container deployment
# and domain settings for the frontend.
############################################

# GCP Project ID
variable "project_id" {
  type        = string
  description = "Google Cloud project ID"
}

# Deployment region (defaulted to asia-south1)
variable "region" {
  type        = string
  default     = "asia-south1"
  description = "Region to deploy the Cloud Run service"
}

# Name of the Cloud Run service (default: angular-frontend)
variable "service_name" {
  type        = string
  default     = "AngularFrontend"
  description = "Name of the Angular frontend Cloud Run service"
}

# Full Docker image path from Artifact Registry
variable "image_url" {
  type        = string
  description = "Docker image URL in Artifact Registry"
}

# IAM principal allowed to invoke the service
# Examples: "allUsers", or "serviceAccount:firebase-auth@your-project.iam.gserviceaccount.com"
variable "iam_member" {
  type        = string
  description = "IAM member granted invoke access (Cloud Run Invoker)"
}

# Domain name to be mapped and covered under SSL
variable "custom_domain" {
  type        = string
  description = "Custom domain for the Angular frontend (e.g., shop.dev.angular.luxantiq.com)"
}

# Request concurrency limit (max concurrent requests per container)
variable "concurrency" {
  type        = number
  default     = 80
  description = "Number of concurrent requests per container"
}

# Request timeout (in seconds)
variable "timeout_seconds" {
  type        = number
  default     = 300
  description = "Max timeout for each request"
}

# Memory allocation for container (default 512Mi)
variable "memory_limit" {
  type        = string
  default     = "512Mi"
  description = "Amount of memory to allocate to each container instance"
}

# Maximum number of instances Cloud Run can autoscale to
variable "max_scale" {
  type        = string
  default     = "10"
  description = "Maximum number of container instances to scale out to"
}
