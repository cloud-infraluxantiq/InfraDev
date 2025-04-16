############################################################
# Luxantiq DNS + HTTPS SSL Module (Cleaned)
# Handles:
# - Global static IP
# - Managed SSL certificate
# - DNS A records
# - HTTPS forwarding rule (proxy is external)
############################################################

# Global Static IP (used for A records and forwarding)
resource "google_compute_global_address" "lb_ip" {
  name    = "luxantiq-global-ip"
  project = var.project_id
}

# Managed SSL Certificate for all domains
resource "google_compute_managed_ssl_certificate" "ssl_cert" {
  name    = "luxantiq-ssl-cert"
  project = var.project_id

  managed {
    domains = var.domain_names
  }
}

# DNS A Records — One per domain
resource "google_dns_record_set" "a_records" {
  for_each     = toset(var.domain_names)
  name         = "${each.value}."
  type         = "A"
  ttl          = 300
  managed_zone = var.dns_zone
  rrdatas      = [google_compute_global_address.lb_ip.address]
  project      = var.project_id
}

# Target HTTPS Proxy
resource "google_compute_target_https_proxy" "https_proxy" {
  name             = "luxantiq-https-proxy"
  url_map          = var.url_map
  ssl_certificates = [google_compute_managed_ssl_certificate.ssl_cert.self_link]
  project          = var.project_id
}

# Global Forwarding Rule
resource "google_compute_global_forwarding_rule" "https_forwarding" {
  name       = "luxantiq-https-forwarding-rule"
  ip_address = google_compute_global_address.lb_ip.address
  port_range = "443"
  target     = google_compute_target_https_proxy.https_proxy.self_link
  project    = var.project_id
}
