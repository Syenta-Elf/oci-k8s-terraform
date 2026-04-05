output "vcn_id" {
    value = oci_core_vcn.test_vcn.id
}

output "subnet_ids" {
  value = { for k, v in oci_core_subnet.test_subnets : k => v.id }
}