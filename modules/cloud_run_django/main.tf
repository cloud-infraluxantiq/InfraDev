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
#Ensure resource is created in correct GCP project
}
template {
  spec {
    containers {
      image = var.image_url

                  resources {
        limits = {memory = var.memory_limit #Allocate memory per container}

        dynamic "env" {
          for_each = var.secret_env_vars content {
            name = env.key value_from {
              secret_key_ref { secret = env.value version = "latest" }
            }
          }
        }

        container_concurrency = var.concurrency #Max simultaneous requests per
                                    container timeout_seconds =
            var.timeout_seconds #Request timeout limit
# ✅ Connect to Cloud SQL via VPC Access Connector(for private IP)
                vpc_access {
          connector = var.vpc_connector egress = "ALL_TRAFFIC"
        }
      }

      metadata {
        annotations = {
#Required for VPC access to be recognized in Cloud Run
          "run.googleapis.com/vpc-access-connector" =
              var.vpc_connector "autoscaling.knative.dev/maxScale" =
                  var.max_scale
        }
      }
    }

    autogenerate_revision_name = true

        traffic {
      percent = 100 latest_revision = true
    }
  }

#-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
#IAM Binding for Firebase Authentication
#This ensures only authenticated users / integrations
#can invoke the Django Cloud Run service.
#-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
  resource
      "google_cloud_run_service_iam_member"
      "firebase_auth" {
        location = var.region service =
            google_cloud_run_service.django.name role =
                "roles/run.invoker" member =
                    var.iam_member #Example :
                        "serviceAccount:firebase-auth@project.iam."
                        "gserviceaccount.com" project = var.project_id
      }
#-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
#Output : Cloud Run URL for Django API
#Useful for monitoring, DNS config, and CI / CD
#-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
  output "cloud_run_url" {
    value = google_cloud_run_service.django.status[0].url description =
        "Live URL of the deployed Django Cloud Run API service"
  }
