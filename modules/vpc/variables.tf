############################################################
# Input Variables: Luxantiq VPC Module
# Defines core VPC, subnet, NAT, and firewall configuration
############################################################

# Name of the custom VPC

variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}

# Map of named subnets
# Each key is the subnet name and maps to CIDR, region, and optional secondary IP ranges
variable "subnets" {
  description = "Map of subnets with CIDR, region, and optional secondary ranges"
  type = map(object({
    cidr             = string
    region           = string
    secondary_ranges = map(string)
  }))
}

# Region to deploy Cloud NAT and Cloud Router
variable "nat_region" {
  description = "Region for NAT configuration"
  type        = string
}

# Region to create the VPC connector for Cloud Run / Serverless
variable "vpc_connector_region" {
  description = "Region for VPC Serverless Connector"
  type        = string
}

# CIDR block used by the VPC connector (must not overlap with subnets)
variable "vpc_connector_cidr" {
  description = "CIDR range for VPC connector"
  type        = string
}

# Map of firewall rule definitions keyed by rule name
variable "firewall_rules" {
  type = map(object({
    description          = string
    direction            = string
    priority             = number
    ranges               = list(string)
    allow_protocol_ports = list(object({
      protocol = string
      ports    = list(string)
    }))
    target_tags = list(string)
  }))
}
