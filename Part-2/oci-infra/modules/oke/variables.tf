variable "cluster_name"{
    type = string
}

variable "tenancy_ocid" {
  type = string
}


variable "cluster_kubernetes_version" {
  type = string
}

variable "vcn_id" {
  type = string
}

variable "node_pool_names" {
  type = set(string)
}

variable "node_pool_node_shape" {
  type = string
}

variable "node_pool_subnet_ids" {
  type = string
}

variable "node_pool_node_shape_config_memory_in_gbs" {
  type = string
}
variable "node_pool_node_shape_config_ocpus" {
  type = string
}

variable "node_pool_image_id" {
  type = string
}

variable "availability_domain" {
  type = string
}