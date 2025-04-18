# ------------------------
# Core Configuration
# ------------------------
project_id     = "cloud-infra-dev"
region         = "asia-south1"
#project_number = "398990037605"

# ------------------------
# Cloud Run Images
# ------------------------
django_image_url = "asia-south1-docker.pkg.dev/cloud-infra-dev/backend/djangoapi:latest"
angular_image_url = "asia-south1-docker.pkg.dev/cloud-infra-dev/frontend/angularfrontend:latest"
# ------------------------
# machine type
# ------------------------
machine_type = "e2-micro"  # Or another valid VM type like n2-standard-2

# ------------------------
# Cloud Run Settings
# ------------------------
cloud_run_django_service_name  = "django-api"
cloud_run_angular_service_name = "angular-frontend"
concurrency     = 80
memory_limit    = "512Mi"
timeout_seconds = 300

# Secret env var mapping (Cloud Run → Secret Manager)
secret_env_vars = {
  DB_PASSWORD = "dev-db-password"
  JWT_SECRET  = "dev-jwt-secret"
  SECRET_KEY  = "dev-django-secret-key"
}

# ------------------------
# Cloud SQL
# ------------------------
db_name                  = "dev_luxantiq"
db_user                  = "your_postgres_username"
cloud_sql_instance_name  = "luxantiq-dev-sql"
tier                     = "db-custom-1-3840"
disk_size                = 10
encryption_key_name      = "projects/cloud-infra-dev/locations/asia-south1/keyRings/terraform-secrets/cryptoKeys/state-key"

# These values are retrieved from Secret Manager
db_password_secret       = "dev-db-password"
db_user_secret           = "dev-db-user"
jwt_secret_secret        = "dev-jwt-secret"
django_secret_key_secret  = "dev-django-secret-key"
angular_secret_key_secret = "dev-angular-secret-key"

# ------------------------
# Firebase Config
# ------------------------
#firebase_project_id   = "cloud-infra-dev-bcf2c"
#firebase_auth_domain  = "cloud-infra-dev-bcf2c.firebaseapp.com"
#firebase_api_key      = "AIzaSyC9XjFtVtRDu5Mq_2xWvrPDNF1tQaECl2k"

# ------------------------
# Razorpay Secrets
# ------------------------
razorpay_api_key_secret = "dev-razorpay-api-key"
razorpay_api_secret_secret = "dev-razorpay-api-secret"

# ------------------------
# DNS & Load Balancer
# ------------------------
dns_zone     = "luxantiq-com-zone"
domain_names = [
  "shop.dev.angular.luxantiq.com",
  "api.dev.django.luxantiq.com"
]
url_map = "luxantiq-url-map"

# ------------------------
# Artifact Registry
# ------------------------
repo_name = "djangoapi"

# ------------------------
# VPC rules
# ------------------------

firewall_rules = {
  allow-ssh = {
    description          = "Allow SSH from anywhere"
    direction            = "INGRESS"
    priority             = 1000
    ranges               = ["0.0.0.0/0"]
    allow_protocol_ports = [
      {
        protocol = "tcp"
        ports    = ["22"]
      }
    ]
  }

  allow-http = {
    description          = "Allow HTTP traffic"
    direction            = "INGRESS"
    priority             = 1001
    ranges               = ["0.0.0.0/0"]
    allow_protocol_ports = [
      {
        protocol = "tcp"
        ports    = ["80"]
      }
    ]
  }
}
# ------------------------
# Terraform State
# ------------------------
state_bucket_name         = "terraform-state-luxantiq-dev"
enable_terraform_locking  = true

# ------------------------
# VPC Configuration
# ------------------------
vpc_name              = "luxantiq-vpc"
nat_region           = "asia-south1"
vpc_connector_region = "asia-south1"
vpc_connector_cidr   = "10.8.0.0/28"
private_network = "projects/cloud-infra-dev/global/networks/luxantiq-vpc"
vpc_connector        = "luxantiq-vpc-connector"

# ------------------------
# IAM
# ------------------------
iam_member = "serviceAccount:github-deployer@cloud-infra-dev.iam.gserviceaccount.com"
# ------------------------
# Service Accounts
# ------------------------
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
databases = [
  "dev_luxantiq"
]
