resource "google_compute_network" "vpc_network" {
  name = var.vpc_network_name
  auto_create_subnetworks  = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.vpc_network_name}-subnet"
  region        = var.region
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = var.cidr_block
}

