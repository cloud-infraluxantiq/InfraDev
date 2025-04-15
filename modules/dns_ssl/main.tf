
resource "google_compute_global_address" "lb_ip" {
  name = "ecommerce-global-ip"
  project = var.project_id
}

resource "google_compute_managed_ssl_certificate" "ssl_cert" {
  name = "ecommerce-ssl-cert"
  managed {
    domains = [var.domain_name]
    project = var.project_id
}
}

resource "google_compute_health_check" "default" {
  name               = "ecommerce-health-check"
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  http_health_check {
    port = 80
    project = var.project_id
}
}

resource "google_compute_backend_service" "default" {
  name        = "ecommerce-backend"
  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 10

  backend {
    group = var.backend_instance_group
    project = var.project_id
}

  health_checks = [google_compute_health_check.default.self_link]
}

resource "google_compute_url_map" "default" {
  name            = "ecommerce-url-map"
  default_service = google_compute_backend_service.default.self_link
  project = var.project_id
}

resource "google_compute_target_https_proxy" "default" {
  name             = "ecommerce-https-proxy"
  url_map          = google_compute_url_map.default.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.ssl_cert.self_link]
  project = var.project_id
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "ecommerce-https-rule"
  ip_address = google_compute_global_address.lb_ip.address
  port_range = "443"
  target     = google_compute_target_https_proxy.default.self_link
  project = var.project_id
}

resource "google_dns_record_set" "a_record" {
  name         = "${var.domain_name  project = var.project_id
}."
  type         = "A"
  ttl          = 300
  managed_zone = var.dns_zone
  rrdatas      = [google_compute_global_address.lb_ip.address]
}
