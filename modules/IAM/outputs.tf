##############################################
# Outputs: IAM Service Accounts and Keys
# This module exports useful references
# for pipelines, audit logging, or external usage.
##############################################

# ------------------------------------------------
# List of all created service account email IDs
# Useful for reference in other modules or roles
# ------------------------------------------------
output "service_account_emails" {
  description = "List of all service account email addresses created by this module"
  value       = [for sa in google_service_account.service_accounts : sa.email]
}

# ------------------------------------------------
# (Optional) Exported private keys of service accounts
# Only includes keys for accounts with `create_key = true`
# ------------------------------------------------
output "service_account_keys" {
  description = "Map of service account keys (base64-encoded private keys)"
  value = {
    for k, v in google_service_account_key.keys :
    k => v.private_key
  }
}
