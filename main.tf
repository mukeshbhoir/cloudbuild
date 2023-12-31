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

resource "google_compute_subnetwork" "delhi-subnet-1" {
  name          = "delhi-subnet-1"
  ip_cidr_range = "200.0.6.0/24"
  region        = "asia-south2"
  network       = google_compute_network.terraform_network.id
}

resource "google_compute_instance" "computevm1" {
  name                      = "test-vm1"
  zone                      = "asia-south1-a"
  machine_type              = "e2-micro"

  network_interface {
    network = "terraform-network"
    subnetwork = "mumbai-subnet-1"
    #network_ip = "200.0.5.15"
  }
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = 20
    }
  }
}

resource "google_compute_instance" "computevm3" {
  name                      = "test-vm3"
  zone                      = "asia-south2-a"
  machine_type              = "e2-micro"

  network_interface {
    network = "terraform-network"
    subnetwork = "delhi-subnet-1"
    #network_ip = "200.0.6.16"
  }
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = 20
    }
  }
}
resource "google_compute_instance" "computevm4" {
  name                      = "test-vm4"
  zone                      = "asia-south1-a"
  machine_type              = "e2-micro"

  network_interface {
    network = "terraform-network"
    subnetwork = "mumbai-subnet-1"
    #network_ip = "200.0.5.16"
  }
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = 20
    }
  }
}
