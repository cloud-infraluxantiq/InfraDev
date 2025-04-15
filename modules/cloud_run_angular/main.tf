
resource "google_cloud_run_service" "angular_app" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.image_url
        ports {
          container_port = 8080
          project = var.project_id
}
        resources {
          limits = {
            memory = var.memory_limit
          }
        }
      }
      container_concurrency = var.concurrency
      timeout_seconds = var.timeout_seconds
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = var.max_scale
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

resource "google_cloud_run_service_iam_member" "invoker" {
  location        = google_cloud_run_service.angular_app.location
  service         = google_cloud_run_service.angular_app.name
  role            = "roles/run.invoker"
  member          = var.iam_member
  project = var.project_id
}

resource "google_compute_managed_ssl_certificate" "angular_ssl" {
  name = "${var.service_name  project = var.project_id
}-ssl"
  managed {
    domains = [var.custom_domain]
  }
}

resource "google_compute_url_map" "url_map" {
  name            = "${var.service_name  project = var.project_id
}-url-map"
  default_service = google_cloud_run_service.angular_app.status[0].url
}

# Additional resources like Cloud Load Balancer, Cloud DNS, Artifact Registry,
# Monitoring and Logging setup can be integrated similarly depending on project structure.
