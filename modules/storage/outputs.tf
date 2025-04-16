
############################################################
# Outputs: Luxantiq Storage Module
# Exposes bucket names and URLs for reference in other modules
############################################################

# List of all bucket names created
output "bucket_names" {
  description = "Names of all provisioned GCS buckets"
  value       = [for b in google_storage_bucket.buckets : b.name]
}

# List of bucket URLs (gs://)
output "bucket_urls" {
  description = "GCS-formatted bucket URLs (gs://bucket-name)"
  value       = [for b in google_storage_bucket.buckets : "gs://${b.name}"]
}
