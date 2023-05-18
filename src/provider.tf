terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.58.0"
    }
  }
  backend "gcs" {
    bucket  = "dhruv-bastion-host-state-files"
    prefix  = "terraform-bastion-host"
  }
}
