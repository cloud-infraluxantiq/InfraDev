
# -------------------------------------
# Load Balancer: Global IP + DNS + SSL
# -------------------------------------

resource "google_compute_managed_ssl_certificate" "luxantiq_cert" {
  name = "luxantiq-ssl-cert"
  managed {
    domains = [
      "shop.dev.angular.luxantiq.com",
      "api.dev.django.luxantiq.com",
      "jenkins.dev.luxantiq.com"
    ]
  }
  project = var.project_id
}

resource "google_compute_global_address" "lb_ip" {
  name    = "luxantiq-lb-ip"
  project = var.project_id
}

resource "google_dns_record_set" "frontend_dns" {
  name         = "shop.dev.angular.luxantiq.com."
  type         = "A"
  ttl          = 300
  managed_zone = var.managed_zone
  rrdatas      = [google_compute_global_address.lb_ip.address]
  project      = var.project_id
}

resource "google_dns_record_set" "api_dns" {
  name         = "api.dev.django.luxantiq.com."
  type         = "A"
  ttl          = 300
  managed_zone = var.managed_zone
  rrdatas      = [google_compute_global_address.lb_ip.address]
  project      = var.project_id
}

resource "google_dns_record_set" "jenkins_dns" {
  name         = "jenkins.dev.luxantiq.com."
  type         = "A"
  ttl          = 300
  managed_zone = var.managed_zone
  rrdatas      = [google_compute_global_address.lb_ip.address]
  project      = var.project_id
}
