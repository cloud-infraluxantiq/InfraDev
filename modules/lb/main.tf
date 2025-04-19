# ---------------------------------------------
# Luxantiq Load Balancer Core Routing Module
# - Handles Cloud Run backends (Angular + Django)
# - Creates Serverless NEGs + URL Map
# ---------------------------------------------

# Serverless NEG for Angular frontend (Cloud Run)
resource "google_compute_region_network_endpoint_group" "angular_neg" {
  name                   = "angular-neg"
  network_endpoint_type  = "SERVERLESS"
  region                 = var.region

  cloud_run {
    service = var.angular_service_name
  }

  project = var.project_id
}

# Serverless NEG for Django API (Cloud Run)
resource "google_compute_region_network_endpoint_group" "django_neg" {
  name                   = "django-neg"
  network_endpoint_type  = "SERVERLESS"
  region                 = var.region

  cloud_run {
    service = var.django_service_name
  }

  project = var.project_id
}

# Backend service for Angular
resource "google_compute_backend_service" "angular_backend" {
  name                  = "angular-backend"
  load_balancing_scheme = "EXTERNAL"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 30
  enable_cdn            = false
  project               = var.project_id

  backend {
    group = google_compute_region_network_endpoint_group.angular_neg.id
  }
}

# Backend service for Django
resource "google_compute_backend_service" "django_backend" {
  name                  = "django-backend"
  load_balancing_scheme = "EXTERNAL"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 30
  enable_cdn            = false
  project               = var.project_id

  backend {
    group = google_compute_region_network_endpoint_group.django_neg.id
  }
}

# URL map for routing to backend services
resource "google_compute_url_map" "default" {
  name            = "luxantiq-url-map"
  default_service = google_compute_backend_service.angular_backend.self_link
  project         = var.project_id

  host_rule {
    hosts        = ["api.dev.django.luxantiq.com"]
    path_matcher = "django-paths"
  }

  path_matcher {
    name            = "django-paths"
    default_service = google_compute_backend_service.django_backend.self_link

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.django_backend.self_link
    }
  }
}
# reserve a static global IP for your HTTPS Load Balancer

resource "google_compute_global_address" "lb_ip" {
  name         = "lb-ip-address"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}
