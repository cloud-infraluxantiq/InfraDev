# DNS + SSL Outputs for Visibility and Cross-Module Use

output "load_balancer_ip" {
  description = "Global static IP address for HTTPS Load Balancer"
  value       = google_compute_global_address.lb_ip.address
}

output "ssl_certificate_id" {
  description = "Self-link of the managed SSL certificate"
  value       = google_compute_managed_ssl_certificate.ssl_cert.id
}

output "forwarding_rule_url" {
  description = "Global forwarding rule target URL"
  value       = google_compute_global_forwarding_rule.https_forwarding.self_link
}
