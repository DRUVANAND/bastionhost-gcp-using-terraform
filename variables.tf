variable "region" {
  description = "The region where the resources will be created."
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where the resources will be created."
  default     = "us-central1-c"
}

variable "machine_type" {
  description = "The machine type for the instances."
  default     = "n1-standard-1"
}

variable "image" {
  description = "The image for the instances."
  default     = "ubuntu-os-cloud/ubuntu-1804-lts"
}

variable "external_ip" {
  description = "The external IP address for the bastion host."
  default     = "35.0.1.0"
}