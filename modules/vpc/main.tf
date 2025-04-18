# ------------------------------------------------------------
# Luxantiq VPC Module
# Provisions custom VPC, subnets, NAT, firewall, PSC & connector
# ------------------------------------------------------------

resource "google_compute_network" "custom_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  description             = "Custom VPC for e-commerce platform"
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnets" {
  for_each                  = var.subnets
  name                      = each.key
  ip_cidr_range             = each.value.cidr
  region                    = each.value.region
  network                   = google_compute_network.custom_vpc.id
  private_ip_google_access  = true
  project                   = var.project_id

  dynamic "secondary_ip_range" {
    for_each = each.value.secondary_ranges
    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }
}

resource "google_compute_router" "nat_router" {
  name    = "${var.vpc_name}-router"
  network = google_compute_network.custom_vpc.name
  region  = var.nat_region
  project = var.project_id
}

resource "google_compute_router_nat" "nat_config" {
  name                               = "${var.vpc_name}-nat"
  router                             = google_compute_router.nat_router.name
  region                             = var.nat_region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  project                            = var.project_id
}

resource "google_compute_global_address" "psc_ip" {
  name    = "${var.vpc_name}-psc-ip"
  project = var.project_id
}

resource "google_vpc_access_connector" "vpc_connector" {
  name          = "${var.vpc_name}-vpc-connector"
  region        = var.vpc_connector_region
  network       = google_compute_network.custom_vpc.name
  ip_cidr_range = var.vpc_connector_cidr
  project       = var.project_id
}

resource "google_compute_firewall" "allow_rules" {
  for_each = var.firewall_rules

  name    = each.key
  network = google_compute_network.custom_vpc.name
  project = var.project_id

  description = each.value.description
  direction   = each.value.direction
  priority    = each.value.priority
  target_tags = each.value.target_tags
  source_ranges = each.value.ranges

  dynamic "allow" {
    for_each = each.value.allow_protocol_ports
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }
}
