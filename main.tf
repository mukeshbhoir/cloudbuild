resource "google_compute_network" "Terraform_network" {
  name                    = "Terraform-vpc"
  auto_create_subnetworks = "false"
  description             = "This is Testing Vpc"
}
        
resource "google_compute_subnetwork" "mum-subnet-1" {
  name          = "mumbai-subnet-1"
  ip_cidr_range = "200.0.1.0/24"
  region        = "asia-south1-a"
  network       = google_compute_network.vpc_network.id
}
  resource "google_compute_subnetwork" "subnet-2" {
  name          = "delhi-subnet"
  ip_cidr_range = "200.0.2.0/24"
  region        = "asia-south1-b"
  network       = google_compute_network.vpc_network.id
}
resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  project = "devops-counsel-demo"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal"
  project = "devops-counsel-demo"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }
  allow {
  protocol = "udp"
    ports    = ["1-65535"]
  }
   allow {
  protocol = "icmp"
  }
  source_ranges = ["200.0.0.0/24", "200.0.1.0/24" ]
}

