module "network" {
  source = "./modules/network"
  # input variables buraya
    tenancy_ocid = var.tenancy_ocid
    subnet_cidr_block = "10.0.1.0/24"
    subnet_display_name ="subnet-1"
    vcn_display_name = "my-first-vcn"
    vcn_cidr_blocks = ["10.0.0.0/16"]
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
  node_pool_subnet_ids = module.network.subnet_id
  node_pool_node_shape_config_memory_in_gbs = "12"
  node_pool_node_shape_config_ocpus = "2"
  node_pool_image_id = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa5ahoi7btznapz7zaolvehrvqxjtjpdrenqyl3pe5qt7i2yqver6a"
  availability_domain = "jZEu:EU-FRANKFURT-1-AD-3"
}
