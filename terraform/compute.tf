resource "oci_core_instance" "management_compute" {
  availability_domain = local.ad
  compartment_id      = var.compartment_ocid
  source_details {
    source_id   = local.image
    source_type = "image"
  }
  shape = local.shape
  shape_config {
    ocpus         = 1
    memory_in_gbs = 16
  }
  display_name = format("%s-management-instance", var.resource_prefix)
  create_vnic_details {
    assign_public_ip          = true
    assign_private_dns_record = false
    subnet_id                 = var.subnet_ocid
  }
  metadata = {
    ssh_authorized_keys = file(var.ssh_authorized_keys_path)
  }
}

resource "oci_core_instance" "target_compute" {
  availability_domain = local.ad
  compartment_id      = var.compartment_ocid
  source_details {
    source_id   = local.image
    source_type = "image"
  }
  shape = local.shape
  shape_config {
    ocpus         = 1
    memory_in_gbs = 16
  }
  display_name = format("%s-target-instance", var.resource_prefix)
  create_vnic_details {
    assign_public_ip          = true
    assign_private_dns_record = false
    subnet_id                 = var.subnet_ocid
  }
  metadata = {
    ssh_authorized_keys = file(var.ssh_authorized_keys_path)
  }
}
