
variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnets" {
  description = "Map of subnets with CIDR and region"
  type = map(object({
    cidr             = string
    region           = string
    secondary_ranges = map(string)
  }))
}

variable "nat_region" {
  description = "Region for NAT configuration"
  type        = string
}

variable "vpc_connector_region" {
  description = "Region for VPC Serverless Connector"
  type        = string
}

variable "vpc_connector_cidr" {
  description = "CIDR range for VPC connector"
  type        = string
}

variable "firewall_rules" {
  description = "Map of firewall rule configurations"
  type = map(object({
    protocol      = string
    ports         = list(string)
    source_ranges = list(string)
    target_tags   = list(string)
    priority      = number
    description   = string
  }))
}
