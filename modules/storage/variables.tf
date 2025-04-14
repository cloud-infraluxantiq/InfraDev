
variable "buckets" {
  description = "A map of bucket configs"
  type = map(object({
    name             = string
    location         = string
    ubla             = bool
    versioning       = bool
    retention_days   = number
    retention_locked = bool
    logging_bucket   = string
    requester_pays   = bool
    cors_origin      = list(string)
    cors_methods     = list(string)
    cors_headers     = list(string)
    cmek_key         = string
    iam_bindings = object({
      role   = string
      member = string
    })
    labels = map(string)
  }))
}
