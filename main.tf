provider "google" {
  project = "demoproject-123456789"
  region  = "us-central1"
}

resource "google_compute_network" "test_vpc" {
  name                    = "vpc1"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "test_subnet" {
  name                     = "subnet1"
  ip_cidr_range            = "10.1.0.0/24"
  region                   = "asia-southeast1"
  network                  = google_compute_network.test_vpc.id
  private_ip_google_access = true
}

resource "google_compute_instance" "test_vm" {
  name         = "vm1"
  zone         = "asia-southeast1-a"
  machine_type = "n1-standard-1"
  allow_stopping_for_update = true

  network_interface {
    network    = "test_vpc"
    subnetwork = "test_subnet"
  }

  boot_disk {
    initialize_params {
      image = "debian-10-buster-v20210916"
      size = 20
    }
  }

  labels = {
    "env" = "test"
  }
}