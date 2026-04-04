output "cluster_id" {
    value = oci_containerengine_cluster.test_cluster.id
}

output "cluster_endpoints" {
    value = oci_containerengine_cluster.test_cluster.endpoints
}