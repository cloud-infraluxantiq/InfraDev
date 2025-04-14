
variable "project_id" { type = string }
variable "region" { type = string }
variable "instance_name" { type = string }
variable "tier" { type = string }
variable "disk_size" { type = number }
variable "private_network" { type = string }
variable "encryption_key_name" { type = string }
variable "users" {
  type = map(object({
    password = string
  }))
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
