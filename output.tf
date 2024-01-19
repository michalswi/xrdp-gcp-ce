
output "vm_pip" {
  value = google_compute_address.static_ip.address
}

output "user" {
  value = var.user
}

output "ssh" {
  value = join("", ["ssh -i ", local_file.ssh_private_key.filename, " ", var.user, "@", google_compute_address.static_ip.address, " -vv"])
}
