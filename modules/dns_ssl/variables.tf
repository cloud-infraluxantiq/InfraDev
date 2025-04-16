############################################################
# Input Variables for DNS + SSL + Forwarding Rule
# Used by Luxantiq to bind custom domains to HTTPS Load Balancer
############################################################

# GCP Project ID
variable "project_id" {
  type        = string
  description = "Google Cloud project ID for provisioning resources"
}

# Domain names to configure (Angular, Django, Jenkins)
variable "domain_names" {
  type        = list(string)
  description = "List of FQDNs to create A records and SSL certificates for"
}

# Name of Cloud DNS managed zone
variable "dns_zone" {
  type        = string
  description = "Pre-created Cloud DNS zone to update A records"
}

# URL map self-link (from Load Balancer module)
variable "url_map" {
  type        = string
  description = "Self-link of the URL map for the HTTPS proxy"
}
