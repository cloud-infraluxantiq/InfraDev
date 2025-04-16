# ---------------------------------------------
# Luxantiq Jenkins CI Terraform Module
# Deploys Jenkins on a small GCE VM with static IP, firewall, IAM, and service account
# ---------------------------------------------

# Reserve a static external IP for Jenkins domain mapping
resource "google_compute_address" "jenkins_ip" {
  name    = "jenkins-static-ip"
  region  = var.region
  project = var.project_id
}

# Create the Jenkins GCE VM instance
resource "google_compute_instance" "jenkins" {
  name         = "jenkins-server"
  machine_type = var.machine_type
  zone         = var.zone

  # Configure Ubuntu 22.04 LTS boot disk
  boot_disk {
    initialize_params {
      image  = "ubuntu-os-cloud/ubuntu-2204-lts"
      project = var.project_id
    }
  }

  # Attach to default network with NAT IP assigned
  network_interface {
    network       = "default"
    access_config {
      nat_ip = google_compute_address.jenkins_ip.address
    }
  }

  # Startup script installs Jenkins + basic auth
  metadata_startup_script = var.startup_script

  # Use a custom service account for Jenkins
  service_account {
    email  = google_service_account.jenkins.email
    scopes = ["cloud-platform"]
  }

  tags = ["jenkins"]
  project = var.project_id
}

# Firewall rule to allow public access to Jenkins UI (port 8080)
resource "google_compute_firewall" "allow_jenkins" {
  name    = "allow-jenkins"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  target_tags   = ["jenkins"]
  source_ranges = ["0.0.0.0/0"]
  project       = var.project_id
}

# Create service account for Jenkins CI/CD
resource "google_service_account" "jenkins" {
  account_id   = "jenkins-ci-sa"
  display_name = "Jenkins CI Service Account"
  project      = var.project_id
}

# IAM bindings to allow Jenkins to deploy to Artifact Registry
resource "google_project_iam_member" "artifact_registry" {
  role   = "roles/artifactregistry.writer"
  member = "serviceAccount:${google_service_account.jenkins.email}"
  project = var.project_id
}

# IAM bindings to allow Jenkins to deploy to Cloud Run
resource "google_project_iam_member" "cloud_run" {
  role   = "roles/run.admin"
  member = "serviceAccount:${google_service_account.jenkins.email}"
  project = var.project_id
}

# IAM bindings to allow Jenkins to access secrets (e.g., for deploy keys)
resource "google_project_iam_member" "secret_manager" {
  role   = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_service_account.jenkins.email}"
  project = var.project_id
}
