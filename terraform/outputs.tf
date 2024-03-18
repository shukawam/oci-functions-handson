output "public_ip_of_management_instance" {
  value = oci_core_instance.management_compute.public_ip
}

output "public_ip_of_target_instance" {
  value = oci_core_instance.target_compute.public_ip
}
