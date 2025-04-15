
variable "db_password" {
  description = "The database password stored in Secret Manager"
  type        = string
}

variable "jwt_secret" {
  description = "JWT signing key"
  type        = string
}


variable "db_password" {
  description = "The database password for Django, stored in Secret Manager"
  type        = string
}

variable "jwt_secret" {
  description = "JWT secret key for user authentication"
  type        = string
}
