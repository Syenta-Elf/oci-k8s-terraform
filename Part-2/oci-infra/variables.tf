variable "region" {
  type = string
}
variable "tenancy_ocid" {
  type = string
}
variable "user_ocid" {
  type = string
}
variable "private_key_path" {
  type = string
}
variable "fingerprint" {
  type = string
}

variable "bucket_name" {
  type = string
}
variable "bucket_namespace" {
  type = string
}

variable "environment" {
  type = string
  default = "dev"
}