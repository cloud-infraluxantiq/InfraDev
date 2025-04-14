
resource "google_artifact_registry_repository" "django_repo" {
  provider         = google
  location         = var.region
  repository_id    = var.repo_name
  description      = "Django container repo"
  format           = "DOCKER"
}
