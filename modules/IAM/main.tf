
resource "google_service_account" "service_accounts" {
  for_each     = var.service_accounts
  account_id   = each.key
  display_name = each.value.display_name
  description  = each.value.description
  project = var.project_id
}

resource "google_project_iam_member" "role_bindings" {
  for_each = {
    for sa_key, sa_data in var.service_accounts :
    "${sa_key  project = var.project_id
}-${sa_data.role}" => {
      sa_email = google_service_account.service_accounts[sa_key].email
      role     = sa_data.role
    }
  }

  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${each.value.sa_email}"
}

resource "google_service_account_key" "keys" {
  for_each           = { for k, v in var.service_accounts : k => v if v.create_key   project = var.project_id
}
  service_account_id = google_service_account.service_accounts[each.key].name
  keepers = {
    service_account_email = google_service_account.service_accounts[each.key].email
  }
}
