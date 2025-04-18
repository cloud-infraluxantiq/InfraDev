###############################################
# Terraform Root Module - Luxantiq Cloud Infra
# Purpose: Load and configure all infrastructure modules
###############################################

# -----------------------------------------
# Google Cloud Provider Configuration
# -----------------------------------------
provider "google" {
  project = var.project_id
  region  = var.region
}

# -------------------------
# VPC & Subnet Provisioning
# -------------------------
module "vpc" {
  source     = "./modules/vpc"
  project_id = var.project_id
  region     = var.region
}

# ----------------------------------
# Django Backend on Cloud Run (Secure)
# ----------------------------------
module "cloud_run_django" {
  source     = "./modules/cloud_run_django"
  project_id = var.project_id
  region     = var.region

  service_name             = var.cloud_run_django_service_name
  image_url                = var.django_image_url
  timeout_seconds          = 300
  database_connection_name = module.sql_postgres.connection_name
  secret_env_vars = {
    DB_PASSWORD  = var.db_password_secret
    JWT_SECRET   = var.jwt_secret_secret
    SECRET_KEY   = var.django_secret_key_secret
  }
  vpc_connector = module.vpc.vpc_connector_name
  memory_limit  = "512Mi"
  concurrency   = 80
}

# ----------------------------------
# Angular Frontend on Cloud Run (Public)
# ----------------------------------
module "cloud_run_angular" {
  source     = "./modules/cloud_run_angular"
  project_id = var.project_id
  region     = var.region

  service_name    = var.cloud_run_angular_service_name
  image_url       = var.angular_image_url
  iam_member      = "allUsers"
  custom_domain   = var.angular_domain
  concurrency     = 80
  timeout_seconds = 300
  memory_limit    = "512Mi"
  max_scale       = "10"
}


# ----------------------------
# Cloud SQL (PostgreSQL) Setup
# ----------------------------
module "sql_postgres" {
  source     = "./modules/sql_postgres"
  project_id = var.project_id
  region     = var.region
}

# --------------------------------
# HTTPS Load Balancer Configuration
# --------------------------------
module "lb" {
  source     = "./modules/lb"
  project_id = var.project_id
  region     = var.region
}

# -----------------------------
# Secret Manager Secret Creation
# -----------------------------
module "secrets" {
  source     = "./modules/secrets"
  project_id = var.project_id
  region     = var.region
}

# ------------------------------------------
# Cloud Monitoring - Uptime Checks & Alerts
# ------------------------------------------
module "monitoring" {
  source     = "./modules/monitoring"
  project_id = var.project_id
  region     = var.region
}
