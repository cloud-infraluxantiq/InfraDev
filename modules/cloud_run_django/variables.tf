
variable "project_id" { type = string }
variable "region" { type = string }
variable "service_name" { type = string }
variable "image_url" { type = string }
variable "memory_limit" { type = string }
variable "concurrency" { type = number }
variable "timeout_seconds" { type = number }
variable "database_connection_name" { type = string }
variable "secret_env_vars" {
  type = map(string)
}
variable "vpc_connector" { type = string }
