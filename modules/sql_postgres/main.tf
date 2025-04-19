# ----------------------------------------------------------
# Luxantiq SQL Postgres Module
# Provisions private Cloud SQL instance with IAM + backups
# ----------------------------------------------------------

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
      day          = 7
      hour         = 2
      update_track = "stable"
    }

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.private_network

      #require_ssl  = true
    }

    dynamic "database_flags" {
      for_each = var.database_flags
      content {
        name  = database_flags.value.name
        value = database_flags.value.value
      }
    }
  }

  deletion_protection   = true
  encryption_key_name   = var.encryption_key_name
}

# ✅ Create DB user (e.g., postgres) using password from Secret Manager
resource "google_sql_user" "postgres_user" {
  name     = var.db_user
  instance = google_sql_database_instance.postgres_instance.name
  password = data.google_secret_manager_secret_version.db_password.secret_data
  project  = var.project_id
}

# ✅ Create Databases
resource "google_sql_database" "databases" {
  for_each = toset(var.databases)

  name     = each.value
  instance = google_sql_database_instance.postgres_instance.name
  project  = var.project_id
}

# ✅ IAM binding for SQL Admin (e.g., to GitHub deployer SA)
resource "google_project_iam_member" "cloudsql_admin" {
  role    = "roles/cloudsql.admin"
  member = "serviceAccount:${local.service_account_email}"
  project = var.project_id
}
