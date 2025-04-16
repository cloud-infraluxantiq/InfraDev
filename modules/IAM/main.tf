#############################################
# IAM Service Accounts & Role Bindings (Luxantiq)
# This module creates:
# 1. Custom service accounts
# 2. Project-level IAM role bindings
# 3. Optionally, downloadable service account keys
#############################################

# ------------------------------
# Create multiple service accounts
# ------------------------------
resource "google_service_account" "service_accounts" {
  for_each = var.service_accounts

  account_id   = each.key
  display_name = each.value.display_name
  description  = each.value.description
  project      = var.project_id
}

# ----------------------------------------
# Assign IAM roles to the service accounts
# ----------------------------------------
resource "google_project_iam_member" "role_bindings" {
  for_each = {
    for sa_key, sa_data in var.service_accounts :
    "${sa_key}-${sa_data.role}" => {
      sa_email = google_service_account.service_accounts[sa_key].email
      role     = sa_data.role
    }
  }

  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${each.value.sa_email}"
}

# ------------------------------------------------------
# Generate and export keys for service accounts (if set)
# Useful for Terraform, Jenkins, or Cloud Build CI/CD
# ------------------------------------------------------
resource "google_service_account_key" "keys" {
  for_each = {
    for key, value in var.service_accounts :
    key => value if value.create_key
  }

  service_account_id = google_service_account.service_accounts[each.key].name

  keepers = {
    # Triggers key rotation if the service account email changes
    service_account_email = google_service_account.service_accounts[each.key].email
  }

  project = var.project_id
}
