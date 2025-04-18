############################################################
# Input Variables for Django Cloud Run Deployment
# Based on Luxantiq Architecture Standards
############################################################

# Google Cloud project ID
variable "project_id" {
  type        = string
  description = "The GCP project where resources will be deployed"
}

# Region for deployment (e.g., asia-south1)
variable "region" {
  type        = string
  description = "GCP region for Cloud Run and related services"
}

# Name of the Cloud Run service
variable "service_name" {
  type        = string
  description = "Name of the Django Cloud Run service (e.g., django-api)"
}

# Docker image to deploy (from Artifact Registry)
variable "image_url" {
  description = "Docker image URL in Artifact Registry"
  type        = string
}
# Memory allocated per container instance
variable "memory_limit" {
  type        = string
  description = "Memory allocation for each container (e.g., 512Mi, 1Gi)"
}

# Number of concurrent requests per container
variable "concurrency" {
  type        = number
  description = "Concurrency value to limit requests handled per container"
}

# Request timeout for container execution (in seconds)
variable "timeout_seconds" {
  type        = number
  description = "Request timeout setting (default: 300)"
}

# Cloud SQL connection string: project:region:instance
variable "database_connection_name" {
  type        = string
  description = "Cloud SQL connection name used for VPC connector (e.g., cloud-infra-dev:asia-south1:luxantiq-dev-sql)"
}

# Secrets mapped as environment variables
# Format: { "ENV_VAR_NAME" = "secret-manager-name" }
variable "secret_env_vars" {
  type        = map(string)
  description = "Mapping of secret environment variable names to Secret Manager secrets"
}
# VPC Connector used for accessing Cloud SQL privately
variable "vpc_connector" {
  type        = string
  description = "VPC connector name used to route Cloud Run traffic privately"
}
