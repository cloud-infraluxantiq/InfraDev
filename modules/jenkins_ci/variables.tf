############################################################
# Variables for Jenkins CI GCE Deployment
# Includes VM config, startup script, and network settings
############################################################

# GCP Project ID
variable "project_id" {
  type = string
}

# Region (e.g., asia-south1)
variable "region" {
  type = string
}

# Zone (e.g., asia-south1-b)
variable "zone" {
  type = string
}

# Machine type for Jenkins VM (e.g., e2-medium or e2-micro)
variable "machine_type" {
  type    = string
  default = "e2-medium"
}

# Inline startup script to install Jenkins
variable "startup_script" {
  type        = string
  description = "Custom startup script to install Jenkins"
  default     = <<EOT
#!/bin/bash
apt-get update
apt-get install -y openjdk-11-jdk
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get install -y jenkins
systemctl start jenkins
systemctl enable jenkins
EOT
}

# Network name (default or custom VPC)
variable "network" {
  type        = string
  default     = "default"
  description = "VPC network name"
}

# Optional subnet name (used for custom VPC deployment)
variable "subnet" {
  type        = string
  default     = null
  description = "Optional subnet name (used if not default network)"
}

# Optional override: external service account to be used by Jenkins
variable "service_account_email" {
  type        = string
  default     = null
  description = "Service account email to attach to Jenkins VM"
}
