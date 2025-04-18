##########################################
# Luxantiq Terraform Variable Values
# These values override defaults in variables.tf during provisioning.
##########################################

# ------------------------
# Google Cloud Project & Region
# ------------------------


# Docker image references for Cloud Run services
django_image_url   = "asia-south1-docker.pkg.dev/cloud-infra-dev/backend/djangoapi:latest"
angular_image_url  = "asia-south1-docker.pkg.dev/cloud-infra-dev/frontend/angularfrontend:latest"

# ------------------------
# Cloud Run Services
# ------------------------
cloud_run_django_service_name  = "DjangoAPI"
cloud_run_angular_service_name = "AngularFrontend"

# ------------------------
# Domain Names (DNS + SSL)
# ------------------------
angular_domain  = "shop.dev.angular.luxantiq.com"
django_domain   = "api.dev.django.luxantiq.com"
jenkins_domain  = "jenkins.dev.luxantiq.com"

# ------------------------
# Firebase Authentication (via Secret Manager)
# ------------------------
firebase_api_key      = "your_firebase_api_key"
firebase_project_id   = "your_firebase_project_id"
firebase_auth_domain  = "your_firebase_auth_domain"

# ------------------------
# PostgreSQL DB Configuration
# ------------------------
db_name     = "dev_luxantiq"
db_user     = "your_postgres_username"
db_password = "your_postgres_password"

cloud_sql_instance_name = "luxantiq-dev-sql"
databases               = ["dev_luxantiq"]

# ------------------------
# Django Auth Secrets
# ------------------------
jwt_secret        = "your_jwt_secret"
django_secret_key = "your_django_secret_key"

# ------------------------
# Razorpay Keys
# ------------------------
razorpay_api_key    = "your_razorpay_api_key"
razorpay_api_secret = "your_razorpay_api_secret"


# ------------------------
# Terraform Remote State
# ------------------------
state_bucket_name        = "terraform-state-luxantiq-dev"
enable_terraform_locking = true

# ------------------------
# Optional Features
# ------------------------
enable_scheduler = true

# ------------------------
# IAM: Service Accounts & Role Bindings
# Used by Terraform, Jenkins, Cloud Scheduler
# ------------------------
service_accounts = {
  terraform-deployer = {
    display_name = "Terraform Deployer"
    description  = "Used by Terraform to manage GCP infrastructure"
    role         = "roles/editor"
    create_key   = true
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
    create_key   = false
  }
}

# ------------------------
# Artifact Registry
# ------------------------
repo_name = "djangoapi"
