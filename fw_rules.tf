resource "google_compute_firewall" "allow_ssh" {
  name        = "allow-ssh-fw"
  project     = local.project
  network     = google_compute_network.this.name
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
  project     = local.project
  network     = google_compute_network.this.name
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
