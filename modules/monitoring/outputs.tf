# --------------------------------------------
# Outputs: Monitoring Module
# --------------------------------------------

output "uptime_check_display_name" {
  description = "Display name of the uptime check"
  value       = google_monitoring_uptime_check_config.django_api_uptime.display_name
}

output "alert_policy_name" {
  description = "Name of the alert policy for DjangoAPI"
  value       = google_monitoring_alert_policy.uptime_alert.display_name
}
