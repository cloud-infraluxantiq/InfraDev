
############################################################
# Input Variables for DNS + SSL + Load Balancer Module
# Used by Luxantiq for Angular, Django, and Jenkins domains
############################################################

# GCP Project ID
variable "project_id" {
  type        = string
  description = "Google Cloud project where the DNS and SSL resources will be created"
}

# Name of the Cloud DNS managed zone (e.g., luxantiq-com-zone)
variable "dns_zone" {
  type        = string
  description = "Cloud DNS managed zone name for your domain (must be pre-created)"
}

# List of custom domains to bind (must match DNS zone)
# e.g., ["shop.dev.angular.luxantiq.com", "api.dev.django.luxantiq.com", "jenkins.dev.luxantiq.com"]
variable "domain_names" {
  type        = list(string)
  description = "List of fully qualified domain names (FQDNs) to create A records and SSL certs for"
}

# The URL map to attach to the HTTPS proxy (from Load Balancer module)
variable "url_map" {
  type        = string
  description = "Self-link of the URL map to route incoming HTTPS requests"
}
