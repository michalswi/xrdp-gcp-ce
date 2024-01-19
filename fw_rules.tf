resource "google_compute_firewall" "allow_ssh" {
  name        = "allow-ssh-fw"
  project     = var.project
  network     = google_compute_network.vpc_network.name
  target_tags = ["allow-ssh"]
  source_ranges = [
    "<your_ip>",
  ]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow_rdp" {
  name        = "allow-rdp-fw"
  project     = var.project
  network     = google_compute_network.vpc_network.name
  target_tags = ["allow-rdp"]
  source_ranges = [
    "<your_ip>",
  ]
  allow {
    protocol = "tcp"
    ports = [
      "3389",
    ]
  }
}
