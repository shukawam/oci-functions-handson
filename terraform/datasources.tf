data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

data "oci_core_shapes" "shapes" {
  compartment_id = var.compartment_ocid
  filter {
    name   = "name"
    values = ["VM.Standard.E.*Flex"]
    regex  = true
  }
}

data "oci_core_images" "images" {
  compartment_id = var.compartment_ocid
  filter {
    name   = "display_name"
    values = ["Oracle-Linux-Cloud-Developer-8.7-2023.04.28-.*"]
    regex  = true
  }
}
