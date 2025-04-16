###########################################
# Artifact Registry for Luxantiq Containers
# This module provisions a Docker repository
# to store container images for Cloud Run services.
###########################################

resource "google_artifact_registry_repository" "django_repo" {
  provider = google

  # Region where the repository will be created
  location = var.region  # Typically: asia-south1

  # Unique identifier for the repository (e.g., djangoapi, backend)
  repository_id = var.repo_name

  # Optional description for clarity
  description = "Django container repository for Cloud Run deployments"

  # Artifact format — we're storing Docker containers
  format = "DOCKER"

  # Ensure it's created under the correct GCP project
  project = var.project_id
}
