############################################################
# Input Variables for Load Balancer Module (Luxantiq)
# Configures NEGs, backend services, and URL map routing
############################################################

# Google Cloud project ID
variable "project_id" {
  type        = string
  description = "GCP Project ID where resources will be provisioned"
}

# Region to deploy Serverless NEGs (e.g., asia-south1)
variable "region" {
  type        = string
  description = "GCP region where Cloud Run services are deployed"
}

# Angular frontend Cloud Run service name (e.g., angular-frontend)
variable "angular_service_name" {
  type        = string
  description = "Name of the Cloud Run service running Angular frontend"
}

# Django backend Cloud Run service name (e.g., DjangoAPI)
variable "django_service_name" {
  type        = string
  description = "Name of the Cloud Run service running Django API"
}
