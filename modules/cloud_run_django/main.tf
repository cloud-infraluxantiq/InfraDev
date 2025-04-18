############################################################ #
#Cloud Run : Django API Deployment(Luxantiq)
#- Deploys Docker container with secrets injected from Secret Manager
#- Connects to Cloud SQL via VPC connector
#- Secured via IAM(e.g., Firebase Auth)
    ############################################################ #
resource "google_cloud_run_service" "django" {
  name     = var.service_name
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.image_url

        resources {
          limits = {
            memory = var.memory_limit  # Allocate memory per container
          }
        }

     dynamic "env" {
          for_each = var.secret_env_vars
          content {
            name = env.key
            value_from {
              secret_key_ref {
                secret  = env.value
                version = "latest"
              }
            }
          }
        }

        container_concurrency = var.concurrency
        timeout_seconds       = var.timeout_seconds

        vpc_access {
          connector = var.vpc_connector
          egress    = "ALL_TRAFFIC"
        }
      }
    }

    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector
      }
    }
  }

  autogenerate_revision_name = true

  traffic {
    percent         = 100
    latest_revision = true
  }
}

#-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
#IAM Binding for Firebase Authentication
#This ensures only authenticated users / integrations
#can invoke the Django Cloud Run service.
#-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
resource "google_cloud_run_service_iam_member" "firebase_auth" {
  location = var.region
  service  = google_cloud_run_service.django.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
              
