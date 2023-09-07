terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.58.0"
    }
  }
backend "gcs" {
    bucket  = "your-backend-bucket"
    prefix  = "terraform-bastion-host"
  }
}

provider "google" {
  project = "your-project-id"
}

module "bastion" {
  source = "./src"
}
