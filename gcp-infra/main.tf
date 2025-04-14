module "vpc" {
  source     = "./modules/vpc"
  project_id = var.project_id
  region     = var.region
}

module "cloud_run_django" {
  source     = "./modules/cloud_run_django"
  project_id = var.project_id
  region     = var.region
}

module "cloud_run_angular" {
  source     = "./modules/cloud_run_angular"
  project_id = var.project_id
  region     = var.region
}

module "sql_postgres" {
  source     = "./modules/sql_postgres"
  project_id = var.project_id
  region     = var.region
}

module "storage" {
  source     = "./modules/storage"
  project_id = var.project_id
  region     = var.region
}

module "dns_ssl" {
  source     = "./modules/dns_ssl"
  project_id = var.project_id
  region     = var.region
}

module "secrets" {
  source     = "./modules/secrets"
  project_id = var.project_id
  region     = var.region
}

module "monitoring" {
  source     = "./modules/monitoring"
  project_id = var.project_id
  region     = var.region
}

module "jenkins_ci" {
  source     = "./modules/jenkins_ci"
  project_id = var.project_id
  region     = var.region
}

