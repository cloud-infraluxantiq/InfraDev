
terraform {
  backend "gcs" {
    bucket         = "luxantiq-terraform-state"
    prefix         = "state"
    encryption_key = "projects/cloud-infra-dev/locations/global/keyRings/terraform-secrets/cryptoKeys/state-key" # optional if using CMEK
  }
}
