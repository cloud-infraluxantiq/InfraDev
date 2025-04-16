# terraform.tfvars
# -----------------
# Service account setup for Luxantiq dev provisioning and CI/CD

service_accounts = {
  terraform-deployer = {
    display_name = "Terraform Deployer"
    description  = "Used by Terraform to manage GCP infrastructure"
    role         = "roles/editor"
    create_key   = true
  }

  jenkins-agent = {
    display_name = "Jenkins Build Agent"
    description  = "Used by Jenkins to trigger builds and manage deployments"
    role         = "roles/cloudbuild.builds.editor"
    create_key   = true
  }

  cloud-scheduler-executor = {
    display_name = "Scheduler Executor"
    description  = "Used by Cloud Scheduler to publish to Pub/Sub"
    role         = "roles/pubsub.publisher"
    create_key   = false
  }
}
