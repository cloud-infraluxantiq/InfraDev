# --------------------------------------------
# Variables for Monitoring Module
# --------------------------------------------

variable "project_id" {
  type        = string
  description = "Google Cloud project ID"
}

variable "django_domain" {
  type        = string
  description = "Domain name of the Django API used for uptime check"
}
