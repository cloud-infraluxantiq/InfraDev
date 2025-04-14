
output "service_account_emails" {
  value = [for sa in google_service_account.service_accounts : sa.email]
}

output "service_account_keys" {
  value = {
    for k, v in google_service_account_key.keys :
    k => v.private_key
  }
}
