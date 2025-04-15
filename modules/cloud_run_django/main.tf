
resource "google_cloud_run_service" "django" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.image_url
        resources {
          limits = {
            memory = var.memory_limit
            project = var.project_id
}
        }
        env {
          for k, v in var.secret_env_vars : {
            name = k
            value_from {
              secret_key_ref {
                secret  = v
                version = "latest"
              }
            }
          }
        }
      }
      container_concurrency = var.concurrency
      timeout_seconds       = var.timeout_seconds
    }

    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

output "cloud_run_url" {
  value = google_cloud_run_service.django.status[0].url
}
