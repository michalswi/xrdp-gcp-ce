resource "google_compute_network" "vpc_network" {
  name                    = "${var.name}-network"
  project                 = var.project
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.name}-subnet"
  project       = var.project
  ip_cidr_range = "10.10.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_address" "static_ip" {
  name    = "${var.name}-pip"
  region  = var.region
  project = var.project
}

data "google_compute_image" "debian_image" {
  family  = "ubuntu-pro-2204-lts"
  project = "ubuntu-os-pro-cloud"
}

resource "google_compute_instance" "vm" {
  name    = "${var.name}-vm"
  project = var.project
  # machine types
  # https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types_table
  machine_type = "e2-highcpu-4"
  # machine_type = "e2-medium"
  zone = "${var.region}-b"

  tags = [
    "allow-ssh",
    "allow-rdp",
  ]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
      size  = 50
      type  = "pd-balanced"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }

  metadata = {
    ssh-keys = "${var.user}:${tls_private_key.private_key.public_key_openssh}"
  }
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key" {
  content         = tls_private_key.private_key.private_key_pem
  filename        = "./id_rsa"
  file_permission = "0600"
}

resource "local_file" "ssh_public_key" {
  content         = tls_private_key.private_key.public_key_openssh
  filename        = "./id_rsa.pub"
  file_permission = "0644"
}
