resource "google_compute_firewall" "gce_allow_tcp_firewall" {
  name    = var.firewall_name
  network = "test-vpc"
  direction = var.firewall_direction
  priority = var.firewall_priority
  source_ranges = var.firewall_source_range

  allow {
    protocol = "tcp"
    ports    = ["22", "3389","443","80"]
  }

  target_tags = var.target_tags

}

resource "google_compute_firewall" "gce_allow_health_check_probe" {
  name    = "allow-health-check"
  network = "test-vpc"
  # direction = var.firewall_direction
  priority = var.firewall_priority
  direction = var.firewall_direction
  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # target_tags = ["allow-health-check"]

}
