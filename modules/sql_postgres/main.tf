# ----------------------------------------------------------
# Luxantiq SQL Postgres Module
# Provisions private Cloud SQL instance with IAM + backups
# ----------------------------------------------------------

# Cloud SQL Instance (PostgreSQL 14) with private IP
resource "google_sql_database_instance" "postgres_instance" {
  name             = var.instance_name
  region           = var.region
  database_version = "POSTGRES_14"
  project          = var.project_id

  settings {
    tier              = var.tier
    availability_type = "REGIONAL"
    disk_autoresize   = true
    disk_type         = "PD_SSD"
    disk_size         = var.disk_size
    activation_policy = "ALWAYS"

    backup_configuration {
      enabled                        = true
      start_time                     = "03:00"
      point_in_time_recovery_enabled = true
    }

    maintenance_window {
      day          = 7  # Sunday
      hour         = 2
      update_track = "stable"
    }

    ip_configuration {
      ipv4_enabled    = false                   # Enforce private IP only
      private_network = var.private_network     # VPC network self-link
      require_ssl     = true
    }

    database_flags = var.database_flags
  }

  deletion_protection = true
  encryption_key_name = var.encryption_key_name
}

# SQL Users (from var.users map)
# Fetch the latest secret version of DB password
data "google_secret_manager_secret_version" "db_password" {
  secret  = var.db_password_secret
  project = var.project_id
}

# Create a single SQL user (e.g., postgres) using password from Secret Manager
resource "google_sql_user" "postgres_user" {
  name     = var.db_user  # E.g., "postgres"
  instance = google_sql_database_instance.postgres_instance.name
  password = data.google_secret_manager_secret_version.db_password.secret_data
  project  = var.project_id
}

# SQL Databases (from var.databases list)
resource "google_sql_database" "databases" {
  for_each = toset(var.databases)

  name     = each.value
  instance = google_sql_database_instance.postgres_instance.name
  project  = var.project_id
}

# IAM binding to allow a specific SA to administer Cloud SQL
resource "google_project_iam_member" "cloudsql_admin" {
  role   = "roles/cloudsql.admin"
  member = "serviceAccount:${var.service_account_email}"
  project = var.project_id
}
