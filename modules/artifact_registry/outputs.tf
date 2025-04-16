##############################################
# Outputs: Artifact Registry
# Useful for CI/CD, Cloud Build, or debugging
##############################################

# Full Docker repository path (e.g., asia-south1-docker.pkg.dev/cloud-infra-dev/djangoapi)
output "repository_url" {
  description = "Fully qualified URL of the Artifact Registry Docker repository"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.django_repo.repository_id}"
}

# Repository ID (just the short name, e.g., djangoapi)
output "repository_id" {
  description = "The Artifact Registry repository ID (short name)"
  value       = google_artifact_registry_repository.django_repo.repository_id
}
