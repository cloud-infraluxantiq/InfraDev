# ------------------------
# Google Provider Setup
# ------------------------
provider "google" {
  credentials = file("terraform-sa-key.json")
  project     = var.project_id
  region      = var.region
}

# ------------------------
# Core Infrastructure Modules
# ------------------------

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

module "lb" {
  source                = "./modules/lb"
  project_id            = var.project_id
  region                = var.region
  angular_service_name  = var.cloud_run_angular_service_name
  django_service_name   = var.cloud_run_django_service_name
}

module "dns_ssl" {
  source     = "./modules/dns_ssl"
  project_id = var.project_id

  dns_zone = "luxantiq-com-zone"

  domain_names = [
    "shop.dev.angular.luxantiq.com",
    "api.dev.django.luxantiq.com",
    "jenkins.dev.luxantiq.com"
  ]

  url_map = module.lb.url_map_self_link
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
  name    = "luxantiq-cleanup-topic"
  project = var.project_id
}

resource "google_cloud_scheduler_job" "cleanup_job" {
  name        = "luxantiq-cleanup-job"
  description = "Trigger cleanup task via Pub/Sub"
  schedule    = "0 2 * * *" # Runs daily at 2:00 AM
  time_zone   = "Asia/Kolkata"

  pubsub_target {
    topic_name = google_pubsub_topic.cleanup_trigger.id
    data       = base64encode("{\"task\":\"cleanup-temp\"}")
  }
}

# ---------------------------------------------------
# Terraform State: Remote Bucket with Locking + CMEK
# ---------------------------------------------------
resource "google_storage_bucket" "terraform_state" {
  name                        = "luxantiq-terraform-state"
  location                    = var.region
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  # Encrypt using your KMS key
  encryption {
    default_kms_key_name = "projects/cloud-infra-dev/locations/global/keyRings/terraform-secrets/cryptoKeys/state-key"
  }

  project = var.project_id
}

resource "google_storage_bucket_iam_binding" "terraform_state_lock" {
  bucket = google_storage_bucket.terraform_state.name
  role   = "roles/storage.admin"

  members = [
    "serviceAccount:terraform-deployer@cloud-infra-dev.iam.gserviceaccount.com"
  ]

  project = var.project_id
}

# -----------------------------------------------------
# Monitoring: Uptime Check + Alerting on Django API
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
      host       = var.django_domain
    }
  }

  project = var.project_id
}

resource "google_monitoring_alert_policy" "uptime_alert" {
  display_name = "DjangoAPI Uptime Alert"
  combiner     = "OR"

  conditions {
    display_name = "DjangoAPI Down"
    condition_threshold {
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND resource.label.\"host\"=\"${var.django_domain}\""
      duration        = "60s"
      comparison      = "COMPARISON_LT"
      threshold_value = 1

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [] # Optional: email, Slack, etc.
  enabled               = true
  project               = var.project_id
}
