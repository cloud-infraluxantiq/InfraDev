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
resource "google_sql_user" "users" {
  for_each = var.users

  name     = each.key
  instance = google_sql_database_instance.postgres_instance.name
  password = each.value.password
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
