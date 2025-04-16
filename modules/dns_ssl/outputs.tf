############################################################
# Outputs: DNS + SSL Module (Luxantiq)
# Exposes global IP, SSL cert, and forwarding rule
############################################################

# Global IP address of the Load Balancer
output "load_balancer_ip" {
  description = "Global static IP for HTTPS Load Balancer"
  value       = google_compute_global_address.lb_ip.address
}

# SSL certificate self-link
output "ssl_certificate_id" {
  description = "Self-link of the managed SSL certificate for custom domains"
  value       = google_compute_managed_ssl_certificate.ssl_cert.id
}

# HTTPS forwarding rule (entry point to LB)
output "forwarding_rule_url" {
  description = "Self-link of the global HTTPS forwarding rule"
  value       = google_compute_global_forwarding_rule.https_forwarding.self_link
}
