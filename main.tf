provider "google" {
  project = "corded-shift-399205"
  region  = "asia-south1"
}

resource "google_compute_network" "terraform_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "false"
  description             = "This is Testing Vpc"
}
        
resource "google_compute_subnetwork" "mumbai-subnet-1" {
  name          = "mumbai-subnet-1"
  ip_cidr_range = "200.0.5.0/24"
  region        = "asia-south1"
  network       = google_compute_network.terraform_network.id
}

resource "google_compute_instance" "computevm1" {
  name                      = "test-vm1"
  zone                      = "asia-south1-a"
  machine_type              = "e2-micro"

  network_interface {
    network = "terraform-network"
    subnetwork = "mumbai-subnet-1"
    network_ip = "200.0.5.15"
    access_config {
    }
  }
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = 20
    }
  }
}

