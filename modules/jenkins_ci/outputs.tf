############################################################
# Outputs: Jenkins CI Module
# Used for referencing Jenkins VM and service account externally
############################################################

# GCE VM instance name (jenkins-server)
output "jenkins_instance_name" {
  description = "Name of the Jenkins VM instance"
  value       = google_compute_instance.jenkins.name
}

# External static IP assigned to Jenkins (for DNS mapping)
output "jenkins_external_ip" {
  description = "Static external IP for accessing Jenkins UI"
  value       = google_compute_address.jenkins_ip.address
}

# Jenkins CI service account email
output "service_account_email" {
  description = "Email of the Jenkins CI service account"
  value       = google_service_account.jenkins.email
}
