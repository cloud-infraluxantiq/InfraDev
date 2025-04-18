# -----------------------------
# Core GCP Project Information
# -----------------------------
project_id     = "cloud-infra-dev"
region         = "asia-south1"
project_number = "398990037605"

# -----------------------------
# Docker Artifact Image URLs
# -----------------------------
django_image_url  = "asia-south1-docker.pkg.dev/cloud-infra-dev/backend/djangoapi:latest"
angular_image_url = "asia-south1-docker.pkg.dev/cloud-infra-dev/frontend/angularfrontend:latest"

# -----------------------------
# Cloud SQL Setup
# -----------------------------
cloud_sql_instance_name = "luxantiq-dev-sql"
db_name                 = "dev_luxantiq"
db_user_secret          = "dev-db-user"
db_password_secret      = "dev-db-password"
database_flags = [
  {
    name  = "max_connections"
    value = "100"
  }
]
databases = ["dev_luxantiq"]

# -----------------------------
# Firebase Configuration
# -----------------------------
firebase_project_id   = "cloud-infra-dev-bcf2c"
firebase_auth_domain  = "cloud-infra-dev-bcf2c.firebaseapp.com"
#firebase_api_key      = "AIzaSyC9XjFtVtRDu5Mq_2xWvrPDNF1tQaECl2k"

# -----------------------------
# Secret Manager References
# -----------------------------
django_secret_key_secret = "dev-django-secret-key"
jwt_secret_secret        = "dev-jwt-secret"
razorpay_api_key_secret  = "dev-razorpay-api-key"
razorpay_api_secret_secret = "dev-razorpay-api-secret"
gcs_service_key_secret   = "dev-gcs-service-key"

# -----------------------------
# IAM Service Accounts
# -----------------------------
service_accounts = {
  terraform-deployer = {
    display_name = "Terraform Deployer"
    description  = "Used by Terraform to manage GCP infrastructure"
    role         = "roles/editor"
    create_key   = false
  }

  github-deployer = {
    display_name = "GitHub Deployer"
    description  = "Used by GitHub Actions to deploy infra"
    role         = "roles/editor"
    create_key   = false
  }

  cloud-scheduler-executor = {
    display_name = "Scheduler Executor"
    description  = "Triggers Pub/Sub from Cloud Scheduler"
    role         = "roles/pubsub.publisher"
    create_key   = false
  }
}

# -----------------------------
# Cloud Run Services
# -----------------------------
cloud_run_django_service_name  = "django-api"
cloud_run_angular_service_name = "angular-frontend"
timeout_seconds = 300
memory_limit    = "512Mi"
concurrency     = 80

# -----------------------------
# Load Balancer / DNS / SSL
# -----------------------------
dns_zone      = "luxantiq-com-zone"
domain_names  = [
  "shop.dev.angular.luxantiq.com",
  "api.dev.django.luxantiq.com"
]
url_map       = "luxantiq-url-map"

# -----------------------------
# Artifact Registry
# -----------------------------
repo_name = "djangoapi"

# -----------------------------
# Cloud VPC Networking
# -----------------------------
vpc_name     = "luxantiq-vpc"
nat_region   = "asia-south1"
vpc_connector_region = "asia-south1"
vpc_connector_cidr   = "10.10.0.0/28"
private_network      = "projects/cloud-infra-dev/global/networks/luxantiq-vpc"

subnets = {
  "luxantiq-subnet-1" = {
    cidr             = "10.10.0.0/24"
    region           = "asia-south1"
    secondary_ranges = {}
  }
}

firewall_rules = {
  "allow-ssh" = {
    protocol      = "tcp"
    ports         = ["22"]
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["ssh"]
    priority      = 1000
    description   = "Allow SSH"
  }
}

# -----------------------------
# Cloud SQL Additional
# -----------------------------
users = {
  "dbadmin" = {
    password = "replace-with-secret-manager"
  }
}

# -----------------------------
# Optional Feature Toggles
# -----------------------------
enable_scheduler         = true
enable_terraform_locking = true

# -----------------------------
# Terraform State Bucket
# -----------------------------
state_bucket_name = "terraform-state-luxantiq-dev"
encryption_key_name = "projects/cloud-infra-dev/locations/asia-south1/keyRings/terraform-secrets/cryptoKeys/state-key"
