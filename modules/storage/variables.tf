############################################################
# Input Variables: Luxantiq Storage Module
############################################################

variable "buckets" {
  description = "A map of named bucket configurations and IAM policies"

  type = map(object({
      # Retention Policy
    retention_days   = number         # How long (in days) to retain objects
    retention_locked = bool           # Whether the retention policy is locked

    # Logging
    logging_bucket   = string         # Bucket to send access logs to

    # Billing
    requester_pays   = bool           # Enable requester pays model

    # CORS Configuration
    cors_origin      = list(string)   # Allowed origins
    cors_methods     = list(string)   # Allowed HTTP methods
    cors_headers     = list(string)   # Allowed headers

    # Encryption
    cmek_key         = string         # KMS key to encrypt the bucket

    # IAM Role Binding
    iam_bindings = object({
      role   = string                 # IAM role to apply (e.g., roles/storage.objectViewer)
      member = string                 # IAM member (e.g., user:abc@gmail.com)
    })

    # Bucket Labels
    labels = map(string)             # Key-value tags for organization
  }))
}
