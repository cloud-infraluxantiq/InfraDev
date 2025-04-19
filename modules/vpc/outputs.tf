############################################################
# Outputs: Luxantiq VPC Module
# Exposes VPC, subnets, and connector information
############################################################

# VPC network name
output "vpc_name" {
  description = "The name of the custom VPC network"
  value       = google_compute_network.custom_vpc.name
}
# List of all subnet names created in this VPC
output "subnet_names" {
  description = "Names of subnets created within the VPC"
  value       = [for s in google_compute_subnetwork.subnets : s.name]
}

# Name of the VPC connector (used by Cloud Run for private IP access)
output "vpc_connector_name" {
  description = "Name of the VPC Serverless Access Connector"
  value       = google_vpc_access_connector.vpc_connector.name
}

# Self link output for SQL connection
output "vpc_self_link" {
  description = "Self link of the custom VPC"
  value       = google_compute_network.custom_vpc.self_link
}
