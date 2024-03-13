output "vm_pip" {
  value       = google_compute_address.static_ip.address
  description = "The public IP address of the virtual machine."
}

output "user" {
  value       = var.user
  description = "The username used for the virtual machine."
}

output "ssh" {
  value       = join("", ["ssh -i ", local_file.ssh_private_key.filename, " ", var.user, "@", google_compute_address.static_ip.address, " -vv"])
  description = "The SSH command to connect to the virtual machine."
}
