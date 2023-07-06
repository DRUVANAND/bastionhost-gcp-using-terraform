terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.58.0"
    }
  }
backend "gcs" {
    bucket  = "dhruv-backend-bucket"
    prefix  = "terraform-bastion-host"
  }
}

provider "google" {
  project = "engineer-cloud-nprod"
}

module "bastion" {
  source = "./src"
}
