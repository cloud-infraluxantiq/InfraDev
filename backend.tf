# backend.tf
# ------------------------------
# This config tells Terraform to store its state remotely in GCS.
# Uses a secure, versioned bucket with optional encryption via CMEK.
# This backend must exist before `terraform init`.

terraform {
  backend "gcs" {
    # GCS bucket for storing Terraform state
    bucket = "luxantiq-terraform-state"

    # Subdirectory in the bucket for organizing state files
    prefix = "state"

    # Optional: Customer-managed encryption key for added security
    encryption_key = "projects/cloud-infra-dev/locations/global/keyRings/terraform-secrets/cryptoKeys/state-key"
  }
}
