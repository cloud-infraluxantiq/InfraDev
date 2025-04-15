
# ------------------------
# Google Provider Setup
# ------------------------

provider "google" {
  credentials = file("terraform-sa-key.json")
  project     = var.project_id
  region      = "asia-south1"
}


module "vpc" {
  source     = "./modules/vpc"
  project_id = var.project_id
  region     = var.region
}

module "cloud_run_django" {
  source     = "./modules/cloud_run_django"
  project_id = var.project_id
  region     = var.region
}

module "cloud_run_angular" {
  source     = "./modules/cloud_run_angular"
  project_id = var.project_id
  region     = var.region
}

module "sql_postgres" {
  source     = "./modules/sql_postgres"
  project_id = var.project_id
  region     = var.region
}

module "storage" {
  source     = "./modules/storage"
  project_id = var.project_id
  region     = var.region
}

module "dns_ssl" {
  source     = "./modules/dns_ssl"
  project_id = var.project_id
  region     = var.region
}

module "secrets" {
  source     = "./modules/secrets"
  project_id = var.project_id
  region     = var.region
}

module "monitoring" {
  source     = "./modules/monitoring"
  project_id = var.project_id
  region     = var.region
}

module "jenkins_ci" {
  source     = "./modules/jenkins_ci"
  project_id = var.project_id
  region     = var.region
}




# -----------------------------------------
# Cloud Scheduler + Pub/Sub for automation
# -----------------------------------------

resource "google_pubsub_topic" "cleanup_trigger" {
  name = "luxantiq-cleanup-topic"
}

resource "google_cloud_scheduler_job" "cleanup_job" {
  name             = "luxantiq-cleanup-job"
  description      = "Trigger cleanup task via Pub/Sub"
  schedule         = "0 2 * * *" # Daily at 2:00 AM
  time_zone        = "Asia/Kolkata"

  pubsub_target {
    topic_name = google_pubsub_topic.cleanup_trigger.id
    data       = base64encode("{"task":"cleanup-temp"}")
  }
}



# ----------------------------------------------
# Remote State Bucket: IAM Locking + Encryption
# ----------------------------------------------

resource "google_storage_bucket_iam_binding" "terraform_state_lock" {
  bucket = "luxantiq-terraform-state"
  role   = "roles/storage.admin"

  members = [
    "serviceAccount:terraform-deployer@cloud-infra-dev.iam.gserviceaccount.com"
  ]
}

resource "google_storage_bucket" "terraform_state" {
  name                        = "luxantiq-terraform-state"
  location                    = "asia-south1"
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }

  # Optional: use a CMEK for encryption
  encryption {
    default_kms_key_name = "projects/cloud-infra-dev/locations/global/keyRings/terraform-secrets/cryptoKeys/state-key"
  }
}



# -----------------------------------------------------
# Cloud Monitoring: Basic Uptime Check + Alert Policy
# -----------------------------------------------------

resource "google_monitoring_uptime_check_config" "api_uptime_check" {
  display_name = "DjangoAPI Uptime Check"
  timeout      = "10s"
  period       = "60s"

  http_check {
    path         = "/"
    port         = 443
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type   = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = "api.dev.django.luxantiq.com"
    }
  }
}

resource "google_monitoring_alert_policy" "uptime_alert" {
  display_name = "DjangoAPI Uptime Alert"
  combiner     = "OR"

  conditions {
    display_name = "DjangoAPI Down"
    condition_threshold {
      filter     = "metric.type="monitoring.googleapis.com/uptime_check/check_passed" AND resource.label."host"="api.dev.django.luxantiq.com""
      duration   = "60s"
      comparison = "COMPARISON_LT"
      threshold_value = 1
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [] # Optional: integrate with email, Slack, SMS
  enabled = true
}
