############################################################
# Outputs: DNS + SSL Module
# Exposes useful references for verification, reuse, or CI/CD
############################################################

# Static Global IP used for DNS A records and forwarding rule
output "load_balancer_ip" {
  description = "Static global IP address for the HTTPS Load Balancer"
  value       = google_compute_global_address.lb_ip.address
}

# Self-link of the managed SSL certificate (auto-renewing)
output "ssl_certificate_id" {
  description = "Managed SSL certificate self-link for HTTPS proxy"
  value       = google_compute_managed_ssl_certificate.ssl_cert.id
}

# Global HTTPS forwarding rule
output "forwarding_rule_url" {
  description = "Self-link of the global HTTPS forwarding rule"
  value       = google_compute_global_forwarding_rule.https_forwarding.self_link
}
