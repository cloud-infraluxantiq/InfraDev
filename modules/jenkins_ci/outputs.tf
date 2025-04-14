
output "jenkins_instance_name" {
  value = google_compute_instance.jenkins.name
}

output "jenkins_external_ip" {
  value = google_compute_address.jenkins_ip.address
}

output "service_account_email" {
  value = google_service_account.jenkins.email
}
