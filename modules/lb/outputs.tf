############################################################
# Outputs: Load Balancer Routing Module (Luxantiq)
# Used to link to DNS + SSL module
############################################################

output "url_map_self_link" {
  description = "Self-link of the URL map created for HTTP(S) Load Balancer"
  value       = google_compute_url_map.default.self_link
}
