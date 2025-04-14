
output "secret_ids" {
  value = [for s in google_secret_manager_secret.secrets : s.id]
}

output "secret_versions" {
  value = [for v in google_secret_manager_secret_version.secret_versions : v.id]
}
