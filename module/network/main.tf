resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.vpc_name
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "subnet_name" {
  name          = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
  # secondary_ip_range {
  #   range_name = "tf-test-secondary-range-update1"
  #   ip_cidr_range = "192.168.10.0/28"
  # }
}