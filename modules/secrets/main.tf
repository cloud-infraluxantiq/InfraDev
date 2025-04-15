
resource "google_secret_manager_secret" "db_password_secret" {
  secret_id = "db_password_secret"
  replication {
    automatic = true
    project = var.project_id
}
}

resource "google_secret_manager_secret_version" "db_password_secret_version" {
  secret      = google_secret_manager_secret.db_password_secret.id
  secret_data = var.db_password
  project = var.project_id
}

resource "google_secret_manager_secret" "jwt_secret_key" {
  secret_id = "jwt_secret_key"
  replication {
    automatic = true
    project = var.project_id
}
}

resource "google_secret_manager_secret_version" "jwt_secret_key_version" {
  secret      = google_secret_manager_secret.jwt_secret_key.id
  secret_data = var.jwt_secret
  project = var.project_id
}


resource "google_secret_manager_secret" "db_password_secret" {
  secret_id = "db_password_secret"
  replication {
    automatic = true
    project = var.project_id
}
}

resource "google_secret_manager_secret_version" "db_password_secret_version" {
  secret      = google_secret_manager_secret.db_password_secret.id
  secret_data = var.db_password
  project = var.project_id
}

resource "google_secret_manager_secret" "jwt_secret_key" {
  secret_id = "jwt_secret_key"
  replication {
    automatic = true
    project = var.project_id
}
}

resource "google_secret_manager_secret_version" "jwt_secret_key_version" {
  secret      = google_secret_manager_secret.jwt_secret_key.id
  secret_data = var.jwt_secret
  project = var.project_id
}
