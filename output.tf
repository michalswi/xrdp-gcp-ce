output "vm_pip" {
  description = "The public IP address of the virtual machine."
  value       = google_compute_address.this.address
}

output "user" {
  description = "The username used for the virtual machine."
  value       = local.user
}

output "ssh" {
  description = "The SSH command to connect to the virtual machine."
  value       = join("", ["ssh -i ", local_file.ssh_private_key.filename, " ", local.user, "@", google_compute_address.this.address, ""])
  # value       = join("", ["ssh -i ", local_file.ssh_private_key.filename, " ", local.user, "@", google_compute_address.this.address, " -vv"])
}
