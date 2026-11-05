output "aks_id" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.fqdn
}

output "identity" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.identity[0].principal_id
}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kubelet_identity[0].object_id
}

output "current_kubernetes_version" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.current_kubernetes_version
}

output "node_resource_group_id" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.node_resource_group_id
}