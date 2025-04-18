############################################################
# Input Variables: Cloud SQL PostgreSQL Module
# Used by Luxantiq to provision secure private DB instances
############################################################

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "tier" {
  type = string
}

variable "disk_size" {
  type = number
}

variable "private_network" {
  type = string
}

variable "encryption_key_name" {
  type = string
}

variable "users" {
  type = map(object({
    password = string
  }))
  default = {}
  description = "Deprecated: not used when passwords are fetched from Secret Manager"
}

variable "db_user" {
  type        = string
  description = "The username for the PostgreSQL user"
}

variable "db_password_secret" {
  type        = string
  description = "The Secret Manager name where the DB password is stored"
}

variable "databases" {
  type = list(string)
}

variable "database_flags" {
  type    = list(object({ name = string, value = string }))
  default = []
}

variable "service_account_email" {
  type = string
}
