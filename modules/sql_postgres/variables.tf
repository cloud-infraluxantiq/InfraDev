############################################################
# Input Variables: Cloud SQL PostgreSQL Module
# Used by Luxantiq to provision secure private DB instances
############################################################

# GCP Project ID and region
variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

# SQL Instance name (e.g., luxantiq-dev-sql)
variable "instance_name" {
  type = string
}

# Machine tier (e.g., db-f1-micro, db-custom-1-3840)
variable "tier" {
  type = string
}

# Disk size in GB
variable "disk_size" {
  type = number
}

# VPC self-link for private IP attachment
variable "private_network" {
  type = string
}

# KMS encryption key (CMEK) for storage encryption
variable "encryption_key_name" {
  type = string
}

# User credentials map (e.g., { "admin" = { password = "xyz" } })
variable "users" {
  type = map(object({
    password = string
  }))
}

# List of databases to be created (e.g., ["dev_luxantiq"])
variable "databases" {
  type = list(string)
}

# Optional database flags (e.g., log_min_duration_statement, etc.)
variable "database_flags" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

# SA email to be granted cloudsql.admin role
variable "service_account_email" {
  type = string
}
