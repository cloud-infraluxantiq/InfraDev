# atest stable Google provider (v6.x) — let's align your entire setup with Terraform Google Provider v6.30.0+.
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.30.0"
    }
  }

  required_version = ">= 1.5.0"
}
