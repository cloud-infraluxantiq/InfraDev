
variable "project_id" {
  type = string
}

variable "service_accounts" {
  description = "Map of service accounts and their role assignments"
  type = map(object({
    display_name = string
    description  = string
    role         = string
    create_key   = bool
  }))
}
