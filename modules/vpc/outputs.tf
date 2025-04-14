
output "vpc_name" {
  value = google_compute_network.custom_vpc.name
}

output "subnet_names" {
  value = [for s in google_compute_subnetwork.subnets : s.name]
}

output "vpc_connector_name" {
  value = google_vpc_access_connector.vpc_connector.name
}
