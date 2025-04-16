############################################
# Variables for Artifact Registry Module
# Used to provision Docker-based container repo
############################################

# GCP Project ID
variable "project_id" {
  type        = string
  description = "The Google Cloud project ID where the repository will be created"
}

# GCP Region for the repository (e.g., asia-south1)
variable "region" {
  type        = string
  description = "The region in which to create the Artifact Registry"
}

# Unique ID for the Docker repository (e.g., djangoapi, angularfrontend)
variable "repo_name" {
  type        = string
  description = "The ID/name of the Artifact Registry repository"
}
