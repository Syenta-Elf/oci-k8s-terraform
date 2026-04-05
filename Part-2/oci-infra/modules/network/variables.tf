#VCN
variable "vcn_display_name" {
  type = string
}

variable "vcn_cidr_blocks" {
  type = set(string)
}

variable "tenancy_ocid" {
  type = string
}

variable "subnets" {
  type = map(object({
    cidr_block          = string
    availability_domain = optional(string)
  }))
}