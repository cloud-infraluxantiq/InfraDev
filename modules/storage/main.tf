############################################################
# Luxantiq Storage Module
# Provisions GCS buckets with IAM, CORS, Retention, Logging
############################################################

resource "google_storage_bucket" "buckets" {
  for_each = var.buckets

  name                        = each.value.name
  location                    = each.value.location
  project                     = var.project_id
  force_destroy               = true
  uniform_bucket_level_access = each.value.ubla

  versioning {
    enabled = each.value.versioning
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365
    }
  }

  retention_policy {
    retention_period = each.value.retention_days * 86400
    is_locked        = each.value.retention_locked
  }

  logging {
    log_bucket        = each.value.logging_bucket
    log_object_prefix = "logs/"
  }

  requester_pays = each.value.requester_pays

  cors {
    origin          = each.value.cors_origin
    method          = each.value.cors_methods
    response_header = each.value.cors_headers
    max_age_seconds = 3600
  }

  encryption {
    default_kms_key_name = each.value.cmek_key
  }

  labels = each.value.labels
}

# IAM permission bindings for each bucket
resource "google_storage_bucket_iam_member" "permissions" {
  for_each = {
    for bucket_name, bucket_config in var.buckets :
    bucket_name => bucket_config.iam_bindings
  }

  bucket = google_storage_bucket.buckets[each.key].name
  role   = each.value.role
  member = each.value.member
  project = var.project_id
}
