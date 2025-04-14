
variable "domain_name" {
  description = "The custom domain name (e.g., app.example.com)"
  type        = string
}

variable "dns_zone" {
  description = "Cloud DNS managed zone name"
  type        = string
}

variable "backend_instance_group" {
  description = "Backend instance group for the Load Balancer"
  type        = string
}
