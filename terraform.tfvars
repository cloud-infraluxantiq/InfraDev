##########################################
# Luxantiq Terraform Variable Values
# These values will override the defaults
# in variables.tf during provisioning.
##########################################

# Google Cloud project ID and region
project_id = "cloud-infra-dev"
region     = "asia-south1"

##########################################
# IAM: Service Accounts & Role Bindings
##########################################

service_accounts = {
  terraform-deployer = {
    display_name = "Terraform Deployer"
    description  = "Used by Terraform to manage GCP infrastructure"
    role         = "roles/editor"
    create_key   = true  # Key exported for use in automation (e.g., tf-auth.sh)
  }

  jenkins-agent = {
    display_name = "Jenkins Build Agent"
    description  = "Used by Jenkins to trigger GCP builds and deploys"
    role         = "roles/cloudbuild.builds.editor"
    create_key   = true
  }

  cloud-scheduler-executor = {
    display_name = "Scheduler Executor"
    description  = "Used by Cloud Scheduler to trigger Pub/Sub"
    role         = "roles/pubsub.publisher"
    create_key   = false  # No key needed (Cloud Scheduler uses default runtime identity)
  }
}
##########################################
# Artifact Registry: Repository Name
# This name is passed into the module to define the Docker repo
##########################################

repo_name = "djangoapi"
