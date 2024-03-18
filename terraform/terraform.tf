provider "oci" {
  auth   = "InstancePrincipal"
  region = var.region
}

terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "< 6.0.0"
    }
  }
}
