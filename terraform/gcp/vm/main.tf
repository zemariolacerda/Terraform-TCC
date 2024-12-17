resource "google_compute_network" "vpc_network" {
  name = var.network_name
}

resource "google_compute_subnetwork" "subnet" {
  name          = "main-subnet"
  region        = var.region
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = "10.0.1.0/24"
}

resource "google_compute_instance" "vm_instance" {
  name         = "main-instance"
  machine_type = var.machine_type
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnet.name
    access_config {
    }
  }
}