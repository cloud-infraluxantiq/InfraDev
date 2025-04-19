# ------------------------
# Core Configuration
# ------------------------
project_id     = "cloud-infra-dev"
region         = "asia-south1"
angular_domain = "shop.dev.angular.luxantiq.com"
django_domain  = "api.dev.django.luxantiq.com"
dns_zone       = "luxantiq-com-zone"

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
  SECRET_KEY  = "dev-django-secret-key"
}

# ------------------------
# Cloud SQL
# ------------------------
db_name                  = "dev_luxantiq"
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

# PostgreSQL users (pulled from Secret Manager at runtime)
users = {
  postgres = {
    password = "your-db-password"  # Or load via secrets as string
  }
}

# ------------------------
# Razorpay Secrets
# ------------------------
razorpay_api_key_secret = "dev-razorpay-api-key"
razorpay_api_secret_secret = "dev-razorpay-api-secret"

# ------------------------
# DNS & Load Balancer
# ------------------------

# Ensure this matches your DNS + SSL configuration
domain_names = [
  "shop.dev.angular.luxantiq.com",
  "api.dev.django.luxantiq.com"
]
enable_terraform_locking = true
# ------------------------
# Artifact Registry
# ------------------------
repo_name = "djangoapi"

# ------------------------
# VPC and firewall rules
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
    target_tags = ["ssh-access"]
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
    target_tags = ["http-server"]
  }

  allow-https = {
    description          = "Allow HTTPS traffic"
    direction            = "INGRESS"
    priority             = 1002
    ranges               = ["0.0.0.0/0"]
    allow_protocol_ports = [
      {
        protocol = "tcp"
        ports    = ["443"]
      }
    ]
    target_tags = ["https-server"]
  }
}

# ------------------------
# Terraform State
# ------------------------

state_bucket_name         = "terraform-state-luxantiq-dev"

# ------------------------
# VPC Configuration
# ------------------------
vpc_name              = "luxantiq-vpc"
nat_region           = "asia-south1"
vpc_connector_region = "asia-south1"
vpc_connector_cidr   = "10.8.0.0/28"
subnet               = "default"
private_network = "projects/cloud-infra-dev/global/networks/luxantiq-vpc"
vpc_connector        = "luxantiq-vpc-connector"
# ------------------------
# Subnet block
# ------------------------
subnets = {
  "subnet-1" = {
    cidr              = "10.10.0.0/24"
    region            = "asia-south1"
    secondary_ranges  = {}
  }
}

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

