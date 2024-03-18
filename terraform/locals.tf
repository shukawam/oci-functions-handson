locals {
  ad    = data.oci_identity_availability_domains.ads.availability_domains[0].name
  shape = data.oci_core_shapes.shapes.shapes[0].name
  image = data.oci_core_images.images.images[0].id
}
