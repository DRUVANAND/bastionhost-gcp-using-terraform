# Create the VPC network
resource "google_compute_network" "bastion_vpc" {
  name                    = "bastion-vpc"
  auto_create_subnetworks = false
}

# Create the subnets
resource "google_compute_subnetwork" "subnet_a" {
  name          = "subnet-a"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.bastion_vpc.self_link
  region        = var.region
}

resource "google_compute_subnetwork" "subnet_b" {
  name          = "subnet-b"
  ip_cidr_range = "10.0.2.0/24"
  network       = google_compute_network.bastion_vpc.self_link
  region        = var.region
}

# Create firewall rules
resource "google_compute_firewall" "allow_bastion_host" {
  name    = "allow-bastion-host"
  network = google_compute_network.bastion_vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["bastion-host"]
}

resource "google_compute_firewall" "allow_bastion_host_to_private_server" {
  name    = "allow-bastionhost-to-privateserver"
  network = google_compute_network.bastion_vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags   = ["bastion-host"]
  target_tags   = ["private-server"]
}

# Create the VM instances
resource "google_compute_instance" "web_server" {
  name         = "web-server"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["private-server"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network     = google_compute_network.bastion_vpc.self_link
    subnetwork  = google_compute_subnetwork.subnet_a.self_link
      # No nat_ip specified to prevent the creation of an external IP
  }
}


resource "google_compute_instance" "bastion_host" {
  name         = "bastion-host"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["bastion-host"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = google_compute_network.bastion_vpc.self_link
    subnetwork = google_compute_subnetwork.subnet_b.self_link
    access_config {
      // Ephemeral public IP
    }
  }
}
