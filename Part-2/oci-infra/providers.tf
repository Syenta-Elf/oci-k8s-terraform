terraform {
  backend "oci" {
    # Required
    bucket            = "terraform-state"
    namespace         = "frpfvmcgcium"
    region            = "eu-frankfurt-1"
     # Optional

  }
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "8.8.0"
    }
  }
}

provider "oci" {
  # Configuration options
   tenancy_ocid = var.tenancy_ocid
   user_ocid = var.user_ocid
   private_key_path = var.private_key_path
   fingerprint = var.fingerprint
   region = var.region
}