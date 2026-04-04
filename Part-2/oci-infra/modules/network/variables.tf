#VCN
variable "vcn_display_name" {
  type = string
}

variable "vcn_cidr_blocks" {
  type = set(string)
}
#SUBNET
variable "subnet_display_name" {
  type = string
}

variable "subnet_cidr_block" {
  type = string
}

variable "tenancy_ocid" {
  type = string
}
