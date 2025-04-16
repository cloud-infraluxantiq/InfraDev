############################################################
# Luxantiq DNS + HTTPS SSL Setup for Custom Domains
# - Provisions a global IP
# - Configures managed SSL for multiple subdomains
# - Adds DNS A records to Cloud DNS
# - Connects HTTPS LB forwarding rule to your custom domains
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
    domains = var.domain_names  # List of domains: [angular, django, jenkins]
  }
}

# --------------------------------------------------
# Cloud DNS A Records — one for each domain
# --------------------------------------------------
resource "google_dns_record_set" "a_records" {
  for_each     = toset(var.domain_names)
  name         = "${each.value}."  # Must end with a dot for FQDN
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
  url_map          = var.url_map  # Passed from Load Balancer module
  ssl_certificates = [google_compute_managed_ssl_certificate.ssl_cert.self_link]
  project          = var.project_id
}

# --------------------------------------------------
# Global Forwarding Rule: Routes port 443 to HTTPS proxy
# --------------------------------------------------
resource "google_compute_global_forwarding_rule" "https_forwarding" {
  name       = "luxantiq-https-forwarding-rule"
  ip_address = google_compute_global_address.lb_ip.address
  port_range = "443"
  target     = google_compute_target_https_proxy.https_proxy.self_link
  project    = var.project_id
}
