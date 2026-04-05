locals {
  common_tags = {
    project     = "oci-k8s-terraform"
    environment = var.environment
  }
  is_prod = var.environment == "prod" ? true : false
}


resource "oci_core_vcn" "test_vcn" {
    #Required
    compartment_id = var.tenancy_ocid
    cidr_blocks = var.vcn_cidr_blocks
    display_name = var.vcn_display_name
    freeform_tags = local.common_tags
    lifecycle {
        prevent_destroy = true
    }
    
}



resource "oci_core_subnet" "test_subnets" {
    #Required
    for_each = var.subnets
    compartment_id = var.tenancy_ocid
    vcn_id = oci_core_vcn.test_vcn.id
    cidr_block = each.value.cidr_block
    display_name = each.key
    route_table_id = oci_core_route_table.test_route_table.id
    availability_domain = each.value.availability_domain
    freeform_tags = local.common_tags
    depends_on = [ oci_core_internet_gateway.test_internet_gateway ]
}

resource "oci_core_internet_gateway" "test_internet_gateway" {
    #Required
    compartment_id = var.tenancy_ocid
    vcn_id = oci_core_vcn.test_vcn.id
        freeform_tags = local.common_tags

}

resource "oci_core_route_table" "test_route_table" {
    #Required
    compartment_id = var.tenancy_ocid
    vcn_id = oci_core_vcn.test_vcn.id
        route_rules {
        #Required
        network_entity_id = oci_core_internet_gateway.test_internet_gateway.id

        #Optional
        destination = "0.0.0.0/0"
    }
        freeform_tags = local.common_tags
}
resource "oci_core_vcn" "manual_vcn" {
    compartment_id = var.tenancy_ocid
    cidr_blocks = ["10.0.0.0/16"]
    display_name = "manual-vcn"
    freeform_tags = local.common_tags
    lifecycle {
      prevent_destroy = true
    }

}