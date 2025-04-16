############################################################
# Luxantiq Secrets Module - GCP Secret Manager
# Provisions secrets required by Django, Angular, Payments
############################################################

# ---------------------------
# PostgreSQL DB Password
# ---------------------------
resource "google_secret_manager_secret" "db_password_secret" {
  secret_id = "dev-db-password"
  replication { automatic = true }
  project    = var.project_id
}

resource "google_secret_manager_secret_version" "db_password_secret_version" {
  secret      = google_secret_manager_secret.db_password_secret.id
  secret_data = var.db_password
  project     = var.project_id
}

# ---------------------------
# PostgreSQL DB Username
# ---------------------------
resource "google_secret_manager_secret" "db_user_secret" {
  secret_id = "dev-db-user"
  replication { automatic = true }
  project    = var.project_id
}

resource "google_secret_manager_secret_version" "db_user_secret_version" {
  secret      = google_secret_manager_secret.db_user_secret.id
  secret_data = var.db_user
  project     = var.project_id
}

# ---------------------------
# JWT Signing Secret for Django
# ---------------------------
resource "google_secret_manager_secret" "jwt_secret_key" {
  secret_id = "dev-jwt-secret"
  replication { automatic = true }
  project    = var.project_id
}

resource "google_secret_manager_secret_version" "jwt_secret_key_version" {
  secret      = google_secret_manager_secret.jwt_secret_key.id
  secret_data = var.jwt_secret
  project     = var.project_id
}

# ---------------------------
# Django SECRET_KEY
# ---------------------------
resource "google_secret_manager_secret" "django_secret_key" {
  secret_id = "dev-django-secret-key"
  replication { automatic = true }
  project    = var.project_id
}

resource "google_secret_manager_secret_version" "django_secret_key_version" {
  secret      = google_secret_manager_secret.django_secret_key.id
  secret_data = var.django_secret_key
  project     = var.project_id
}

# ---------------------------
# Firebase: API Key
# ---------------------------
resource "google_secret_manager_secret" "firebase_api_key" {
  secret_id = "dev-firebase-api-key"
  replication { automatic = true }
  project    = var.project_id
}

resource "google_secret_manager_secret_version" "firebase_api_key_version" {
  secret      = google_secret_manager_secret.firebase_api_key.id
  secret_data = var.firebase_api_key
  project     = var.project_id
}

# ---------------------------
# Firebase: Project ID
# ---------------------------
resource "google_secret_manager_secret" "firebase_project_id" {
  secret_id = "dev-firebase-project-id"
  replication { automatic = true }
  project    = var.project_id
}

resource "google_secret_manager_secret_version" "firebase_project_id_version" {
  secret      = google_secret_manager_secret.firebase_project_id.id
  secret_data = var.firebase_project_id
  project     = var.project_id
}

# ---------------------------
# Firebase: Auth Domain
# ---------------------------
resource "google_secret_manager_secret" "firebase_auth_domain" {
  secret_id = "dev-firebase-auth-domain"
  replication { automatic = true }
  project    = var.project_id
}

resource "google_secret_manager_secret_version" "firebase_auth_domain_version" {
  secret      = google_secret_manager_secret.firebase_auth_domain.id
  secret_data = var.firebase_auth_domain
  project     = var.project_id
}

# ---------------------------
# Razorpay: API Key
# ---------------------------
resource "google_secret_manager_secret" "razorpay_api_key" {
  secret_id = "dev-razorpay-api-key"
  replication { automatic = true }
  project    = var.project_id
}

resource "google_secret_manager_secret_version" "razorpay_api_key_version" {
  secret      = google_secret_manager_secret.razorpay_api_key.id
  secret_data = var.razorpay_api_key
  project     = var.project_id
}

# ---------------------------
# Razorpay: API Secret
# ---------------------------
resource "google_secret_manager_secret" "razorpay_api_secret" {
  secret_id = "dev-razorpay-api-secret"
  replication { automatic = true }
  project    = var.project_id
}

resource "google_secret_manager_secret_version" "razorpay_api_secret_version" {
  secret      = google_secret_manager_secret.razorpay_api_secret.id
  secret_data = var.razorpay_api_secret
  project     = var.project_id
}

# ---------------------------
# GCS Service Key (base64-encoded)
# ---------------------------
resource "google_secret_manager_secret" "gcs_service_key" {
  secret_id = "dev-gcs-service-key"
  replication { automatic = true }
  project    = var.project_id
}

resource "google_secret_manager_secret_version" "gcs_service_key_version" {
  secret      = google_secret_manager_secret.gcs_service_key.id
  secret_data = var.gcs_service_key
  project     = var.project_id
}
