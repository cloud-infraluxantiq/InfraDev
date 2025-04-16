# -------------------------------------
# Load Balancer: Global IP + DNS + SSL
# -------------------------------------

# This SSL certificate will secure traffic to Angular, Django, and Jenkins.
# Google will automatically provision and renew the cert for listed domains.
resource "google_compute_managed_ssl_certificate" "luxantiq_cert" {
  name = "luxantiq-ssl-cert"

  managed {
    domains = [
      "shop.dev.angular.luxantiq.com",  # Angular frontend
      "api.dev.django.luxantiq.com",    # Django API backend
      "jenkins.dev.luxantiq.com"        # Jenkins UI on Compute Engine
    ]
  }

  project = var.project_id
}

# This is a globally reserved static IP to be associated with your Load Balancer.
# All frontend traffic will route through this IP.
resource "google_compute_global_address" "lb_ip" {
  name    = "luxantiq-lb-ip"
  project = var.project_id
}

# --------------------------
# Cloud DNS Record Bindings
# --------------------------

# Angular Frontend → Load Balancer IP
resource "google_dns_record_set" "frontend_dns" {
  name         = "shop.dev.angular.luxantiq.com."  # Must end with dot
  type         = "A"
  ttl          = 300
  managed_zone = var.managed_zone  # Assumes DNS zone already created
  rrdatas      = [google_compute_global_address.lb_ip.address]
  project      = var.project_id
}

# Django API Backend → Load Balancer IP
resource "google_dns_record_set" "api_dns" {
  name         = "api.dev.django.luxantiq.com."
  type         = "A"
  ttl          = 300
  managed_zone = var.managed_zone
  rrdatas      = [google_compute_global_address.lb_ip.address]
  project      = var.project_id
}

# Jenkins UI → Load Balancer IP
resource "google_dns_record_set" "jenkins_dns" {
  name         = "jenkins.dev.luxantiq.com."
  type         = "A"
  ttl          = 300
  managed_zone = var.managed_zone
  rrdatas      = [google_compute_global_address.lb_ip.address]
  project      = var.project_id
}
