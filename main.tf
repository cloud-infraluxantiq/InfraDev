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
}

# ----------------------------------
# Angular Frontend on Cloud Run (Public)
# ----------------------------------
module "cloud_run_angular" {
  source     = "./modules/cloud_run_angular"
  project_id = var.project_id
  region     = var.region
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
