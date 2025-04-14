
variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "service_name" {
  type    = string
  default = "angular-app"
}

variable "image_url" {
  description = "Docker image URL in Artifact Registry"
  type        = string
}

variable "iam_member" {
  description = "IAM member (e.g., allUsers, service account)"
  type        = string
}

variable "custom_domain" {
  description = "Custom domain for the service"
  type        = string
}

variable "concurrency" {
  type    = number
  default = 80
}

variable "timeout_seconds" {
  type    = number
  default = 300
}

variable "memory_limit" {
  type    = string
  default = "512Mi"
}

variable "max_scale" {
  type    = string
  default = "10"
}
