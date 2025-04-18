# ------------------------
# Google Provider Setup
# ------------------------
provider "google" {
  project = var.project_id
  region  = var.region
}

# ------------------------
# VPC + Subnet
# ------------------------
module "vpc" {
  source     = "./modules/vpc"
  project_id = var.project_id
  region     = var.region
}
# ------------------------
# Razor pay api key
# ------------------------
#secret_env_vars = {
#  RAZORPAY_API_KEY    = var.razorpay_api_key_secret
#  RAZORPAY_API_SECRET = var.razorpay_api_secret_secret
#}

# ------------------------
# Cloud Run: Django API
# ------------------------
module "cloud_run_django" {
  source                   = "./modules/cloud_run_django"
  project_id               = var.project_id
  region                   = var.region
  service_name             = var.cloud_run_django_service_name
  image_url                = var.django_image_url
  timeout_seconds          = 300
  memory_limit             = "512Mi"
  concurrency              = 80
  database_connection_name = module.sql_postgres.connection_name
  vpc_connector            = module.vpc.vpc_connector_name

  secret_env_vars = {
    DB_PASSWORD           = var.db_password_secret
    JWT_SECRET            = var.jwt_secret_secret
    SECRET_KEY            = var.django_secret_key_secret
    RAZORPAY_API_KEY      = var.razorpay_api_key_secret
    RAZORPAY_API_SECRET   = var.razorpay_api_secret_secret
  }
}
# ------------------------
# Cloud Run: Angular Frontend
# ------------------------
module "cloud_run_angular" {
  source        = "./modules/cloud_run_angular"
  project_id    = var.project_id
  region        = var.region
  service_name  = var.cloud_run_angular_service_name
  image_url     = var.angular_image_url
  timeout_seconds = 300
  memory_limit  = "512Mi"
  concurrency   = 80
  custom_domain = var.angular_domain
  iam_member    = "allUsers"
}

# ------------------------
# SQL (PostgreSQL)
# ------------------------
module "sql_postgres" {
  source     = "./modules/sql_postgres"
  project_id = var.project_id
  region     = var.region

  # ✅ REQUIRED
  instance_name           = var.cloud_sql_instance_name
  tier                    = var.tier
  disk_size               = var.disk_size
  private_network         = module.vpc.vpc_self_link
  encryption_key_name     = var.encryption_key_name
  databases               = var.databases
  users                   = var.users
  db_user                 = var.db_user                        # ✅ add this
  db_password_secret      = var.db_password_secret             # ✅ add this
  database_flags          = var.database_flags
  service_account_email   = var.service_account_email
}
# ------------------------
# Load Balancer + SSL
# ------------------------
module "lb" {
  source                = "./modules/lb"
  project_id            = var.project_id
  region                = var.region
  angular_service_name  = var.cloud_run_angular_service_name
  django_service_name   = var.cloud_run_django_service_name
}

# ------------------------
# Cloud DNS + Managed SSL
# ------------------------
module "dns_ssl" {
  source     = "./modules/dns_ssl"
  project_id = var.project_id
  dns_zone     = "luxantiq-com-zone"
  domain_names = [
    var.angular_domain,
    var.django_domain
  ]
  url_map = module.lb.url_map_self_link  # ✅ Required line
}
# ------------------------
# Secret Manager
# ------------------------
module "secrets" {
  source     = "./modules/secrets"
  project_id = var.project_id
  region     = var.region
}

# ------------------------
# Monitoring (Uptime Check)
# ------------------------
module "monitoring" {
  source     = "./modules/monitoring"
  project_id = var.project_id
  region     = var.region
}
