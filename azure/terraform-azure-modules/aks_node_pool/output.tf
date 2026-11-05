output "node_pool_ids" {
  value = tomap({
    for k, v in azurerm_kubernetes_cluster_node_pool.kubernetes_cluster_node_pool :
    k => v.id
  })
}