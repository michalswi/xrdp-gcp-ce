locals {
  name    = var.name
  project = var.project
  region  = var.region
  user    = var.user
}

resource "google_compute_network" "this" {
  name                    = "${local.name}-vpc"
  project                 = local.project
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "this" {
  name          = "${local.name}-subnet"
  project       = local.project
  ip_cidr_range = "10.10.0.0/16"
  region        = local.region
  network       = google_compute_network.this.id
}

resource "google_compute_address" "this" {
  name    = "${local.name}-pip"
  region  = local.region
  project = local.project
}

data "google_compute_image" "debian_image" {
  family  = "ubuntu-pro-2204-lts"
  project = "ubuntu-os-pro-cloud"
}

resource "google_compute_instance" "this" {
  name    = "${local.name}-vm"
  project = local.project
  # machine types
  # https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types_table
  machine_type = "e2-highcpu-4"
  # machine_type = "e2-medium"
  zone = "${local.region}-a"

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
    network    = google_compute_network.this.name
    subnetwork = google_compute_subnetwork.this.id
    access_config {
      nat_ip = google_compute_address.this.address
    }
  }

  metadata = {
    ssh-keys = "${var.user}:${tls_private_key.this.public_key_openssh}"
  }
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key" {
  content         = tls_private_key.this.private_key_pem
  filename        = "./id_rsa"
  file_permission = "0600"
}

resource "local_file" "ssh_public_key" {
  content         = tls_private_key.this.public_key_openssh
  filename        = "./id_rsa.pub"
  file_permission = "0644"
}
