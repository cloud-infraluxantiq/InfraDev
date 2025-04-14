
resource "google_compute_address" "jenkins_ip" {
  name = "jenkins-static-ip"
  region = var.region
}

resource "google_compute_instance" "jenkins" {
  name         = "jenkins-server"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network       = "default"
    access_config {
      nat_ip = google_compute_address.jenkins_ip.address
    }
  }

  metadata_startup_script = var.startup_script

  service_account {
    email  = google_service_account.jenkins.email
    scopes = ["cloud-platform"]
  }

  tags = ["jenkins"]
}

resource "google_compute_firewall" "allow_jenkins" {
  name    = "allow-jenkins"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  target_tags = ["jenkins"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_service_account" "jenkins" {
  account_id   = "jenkins-ci-sa"
  display_name = "Jenkins CI Service Account"
}

resource "google_project_iam_member" "artifact_registry" {
  role   = "roles/artifactregistry.writer"
  member = "serviceAccount:${google_service_account.jenkins.email}"
}

resource "google_project_iam_member" "cloud_run" {
  role   = "roles/run.admin"
  member = "serviceAccount:${google_service_account.jenkins.email}"
}

resource "google_project_iam_member" "secret_manager" {
  role   = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_service_account.jenkins.email}"
}
