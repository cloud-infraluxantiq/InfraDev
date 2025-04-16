# monitoring module main.tf
# ---------------------------------------------------------
# Luxantiq Monitoring Module
# Uptime Check + Alert Policy for Django API Cloud Run App
# ---------------------------------------------------------

# Uptime check to verify Django API (HTTPS endpoint)
resource "google_monitoring_uptime_check_config" "django_api_uptime" {
  display_name = "DjangoAPI Uptime Check"
  timeout      = "10s"
  period       = "60s"
  project      = var.project_id

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
}

# Alert policy to notify when uptime check fails
resource "google_monitoring_alert_policy" "uptime_alert" {
  display_name = "DjangoAPI Uptime Alert"
  combiner     = "OR"
  project      = var.project_id

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

  notification_channels = [] # Optional: Email, SMS, Slack, etc.
  enabled               = true
}
