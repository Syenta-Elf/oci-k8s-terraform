data "terraform_remote_state" "network" {
  backend = "oci"
  config = {
    bucket    = "terraform-state"
    namespace = "frpfvmcgcium"
    region    = "eu-frankfurt-1"
  }
}

output "vcn_id" {
  value = data.terraform_remote_state.network.outputs.vcn_id
}