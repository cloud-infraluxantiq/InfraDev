########################################################
# Cloud Run Deployment for Angular Frontend (Static SPA)
# Deploys a container image, assigns IAM role, and maps domain
########################################################

resource "google_cloud_run_service" "angular_app" {
  name     = var.service_name
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.image_url  # Built Angular image from Artifact Registry

        ports {
          container_port = 8080  # Default Cloud Run port for HTTP traffic
        }

        resources {
          limits = {
            memory = var.memory_limit  # e.g., "256Mi"
          }
        }
      }

      container_concurrency = var.concurrency       # Number of requests per container
      timeout_seconds       = var.timeout_seconds   # Max duration of request
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = var.max_scale  # Upper bound for autoscaling
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

# ---------------------------------------------------------
# IAM Binding to allow access to the Cloud Run service
# Typically used to bind Firebase Auth or specific members
# ---------------------------------------------------------
resource "google_cloud_run_service_iam_member" "invoker" {
  location = google_cloud_run_service.angular_app.location
  service  = google_cloud_run_service.angular_app.name
  role     = "roles/run.invoker"
  member   = var.iam_member  # e.g., "allUsers" or "serviceAccount:firebase@..."
  project  = var.project_id
}

# ---------------------------------------------------------
# (Optional) Managed SSL certificate for custom domain
# This auto-provisions certs for mapped domains
# ---------------------------------------------------------
resource "google_compute_managed_ssl_certificate" "angular_ssl" {
  name = "${var.service_name}-ssl"
  managed {
    domains = [var.custom_domain]  # e.g., shop.dev.angular.luxantiq.com
  }
  project = var.project_id
}

# ---------------------------------------------------------
# (Optional) URL map to route external requests to Cloud Run
# Can be used in HTTPS Load Balancer setup
# ---------------------------------------------------------
resource "google_compute_url_map" "url_map" {
  name = "${var.service_name}-url-map"

  # WARNING: Not usually correct to use status[0].url directly
  # This is a placeholder — ideally you should point to a backend service (like serverless NEG)
  default_url_redirect {
    https_redirect = true
    strip_query    = false
  }

  project = var.project_id
}

# 🔧 Note:
# This module assumes you're configuring DNS + Load Balancer separately in lb.tf
# Additional integration (Cloud CDN, Cloud Armor) can be added externally.
