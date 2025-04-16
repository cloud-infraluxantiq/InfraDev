############################################################
# Luxantiq DNS + HTTPS SSL Setup for Custom Domains
# - Provisions global IP for Load Balancer
# - Configures managed SSL certificate for subdomains
# - Adds DNS A records using Cloud DNS
# - Configures HTTPS proxy and forwarding rules
############################################################

# ----------------------------------------
# Global Static IP for HTTPS Load Balancer
# ----------------------------------------
resource "google_compute_global_address" "lb_ip" {
  name    = "luxantiq-global-ip"
  project = var.project_id
}

# --------------------------------------------------
# Managed SSL Certificate for Angular, Django, Jenkins
# --------------------------------------------------
resource "google_compute_managed_ssl_certificate" "ssl_cert" {
  name    = "luxantiq-ssl-cert"
  project = var.project_id

  managed {
    domains = var.domain_names  # Example: ["shop.dev.angular...", "api.dev.django...", "jenkins.dev..."]
  }
}

# --------------------------------------------------
# Cloud DNS A Records — one per domain
# --------------------------------------------------
resource "google_dns_record_set" "a_records" {
  for_each     = toset(var.domain_names)
  name         = "${each.value}."  # FQDN must end with a dot
  type         = "A"
  ttl          = 300
  managed_zone = var.dns_zone
  rrdatas      = [google_compute_global_address.lb_ip.address]
  project      = var.project_id
}

# --------------------------------------------------
# Target HTTPS Proxy connects URL Map to SSL Cert
# --------------------------------------------------
resource "google_compute_target_https_proxy" "https_proxy" {
  name             = "luxantiq-https-proxy"
  url_map          = var.url_map  # Passed from LB module (e.g., backend routing)
  ssl_certificates = [google_compute_managed_ssl_certificate.ssl_cert.self_link]
  project          = var.project_id
}

# --------------------------------------------------
# Global Forwarding Rule: Routes HTTPS traffic to proxy
# --------------------------------------------------
resource "google_compute_global_forwarding_rule" "https_forwarding" {
  name       = "luxantiq-https-forwarding-rule"
  ip_address = google_compute_global_address.lb_ip.address
  port_range = "443"
  target     = google_compute_target_https_proxy.https_proxy.self_link
  project    = var.project_id
}
