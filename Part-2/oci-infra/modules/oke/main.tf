resource "oci_containerengine_cluster" "test_cluster" {
    #Required
    compartment_id = var.tenancy_ocid
    kubernetes_version = var.cluster_kubernetes_version
    name = var.cluster_name
    vcn_id = var.vcn_id
}

#resource "oci_containerengine_node_pool" "test_node_pool" {
#    #Required
#    for_each = var.node_pool_names
#    cluster_id = oci_containerengine_cluster.test_cluster.id
#    compartment_id = var.tenancy_ocid
#    name = each.value
#    node_shape = var.node_pool_node_shape
#    kubernetes_version = var.cluster_kubernetes_version
#    node_config_details {
#        size = 1  # her pool'da 1 node
#
#    placement_configs {
#        availability_domain = var.availability_domain
#        subnet_id           = var.node_pool_subnet_ids
#     }
#    }
#    node_shape_config {
#        #Optional
#        memory_in_gbs = var.node_pool_node_shape_config_memory_in_gbs
#        ocpus = var.node_pool_node_shape_config_ocpus
#    }
#
#    node_source_details {
#        source_type = "IMAGE"
#        image_id    = var.node_pool_image_id
#    }
#}