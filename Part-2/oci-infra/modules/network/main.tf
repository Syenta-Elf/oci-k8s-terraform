resource "oci_core_vcn" "test_vcn" {
    #Required
    compartment_id = var.tenancy_ocid
    cidr_blocks = var.vcn_cidr_blocks
    display_name = var.vcn_display_name
}

resource "oci_core_subnet" "test_subnet" {
    #Required
    compartment_id = var.tenancy_ocid
    vcn_id = oci_core_vcn.test_vcn.id
    cidr_block = var.subnet_cidr_block
    display_name = var.subnet_display_name
}