
resource "google_secret_manager_secret" "secrets" {
  for_each = var.secrets

  secret_id = each.key
  replication {
    automatic = true
  }

  labels = each.value.labels
  annotations = each.value.annotations
}

resource "google_secret_manager_secret_version" "secret_versions" {
  for_each = var.secrets

  secret      = google_secret_manager_secret.secrets[each.key].id
  secret_data = each.value.value
}

resource "google_secret_manager_secret_iam_member" "access" {
  for_each = {
    for key, val in var.secrets :
    key => {
      secret  = key
      members = val.accessors
    }
  }

  secret_id = google_secret_manager_secret.secrets[each.key].id
  role      = "roles/secretmanager.secretAccessor"
  member    = each.value.members
}
