module "network" {
  source = "./modules/network"
  # input variables buraya
    tenancy_ocid = var.tenancy_ocid
    vcn_display_name = "my-first-vcn"
    vcn_cidr_blocks = ["10.0.0.0/16"]
    subnets = {
      "subnet-1" = {
        cidr_block = "10.0.1.0/24"
      }
      "subnet-2" = {
        cidr_block = "10.0.2.0/24"
        availability_domain = "jZEu:EU-FRANKFURT-1-AD-2"
      }
      "subnet-3" = {
        cidr_block = "10.0.3.0/24"
        availability_domain = "jZEu:EU-FRANKFURT-1-AD-3"
      }
    }
    environment = "prod"
}

resource "oci_objectstorage_bucket" "test_bucket" {
    #Required
    compartment_id = var.tenancy_ocid
    name = var.bucket_name
    namespace = var.bucket_namespace
}

module "cluster" {
  source = "./modules/oke"
  cluster_name = "cluster-1"
  tenancy_ocid = var.tenancy_ocid
  cluster_kubernetes_version = "v1.32.1"
  vcn_id = module.network.vcn_id
  node_pool_names = ["foo-1","foo-2"]
  node_pool_node_shape= "VM.Standard.E2.1.Micro"
  node_pool_subnet_ids = module.network.subnet_ids["subnet-1"]
  node_pool_node_shape_config_memory_in_gbs = "12"
  node_pool_node_shape_config_ocpus = "2"
  node_pool_image_id = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa5ahoi7btznapz7zaolvehrvqxjtjpdrenqyl3pe5qt7i2yqver6a"
  availability_domain = "jZEu:EU-FRANKFURT-1-AD-3"
}


