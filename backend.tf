
terraform {
  backend "remote" {
    organization = "your-org"

    workspaces {
      name = "your-workspace"
    }
  }
}
