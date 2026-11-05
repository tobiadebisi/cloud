resource "azurerm_kubernetes_cluster_node_pool" "kubernetes_cluster_node_pool" {
  for_each = var.node_pools

  name                  = each.value.name
  orchestrator_version  = each.value.orchestrator_version
  kubernetes_cluster_id = each.value.kubernetes_cluster_id
  vm_size               = each.value.vm_size

  min_count              = each.value.min_count
  max_count              = each.value.max_count
  vnet_subnet_id         = each.value.vnet_subnet_id
  node_public_ip_enabled = each.value.node_public_ip_enabled
  zones                  = each.value.zones
  node_labels            = each.value.node_labels
  node_taints            = try(each.value.node_taints, null)
  auto_scaling_enabled   = each.value.auto_scaling_enabled
  mode                   = each.value.mode
  os_disk_size_gb        = each.value.os_disk_size_gb

  dynamic "upgrade_settings" {
    for_each = each.value.upgrade_settings != null ? [each.value.upgrade_settings] : []

    content {
      drain_timeout_in_minutes      = upgrade_settings.value.drain_timeout_in_minutes
      max_surge                     = upgrade_settings.value.max_surge
      node_soak_duration_in_minutes = upgrade_settings.value.node_soak_duration_in_minutes
    }
  }

  tags = merge(
    {
      environment = var.environment
    },
    {
      callcenter = var.callcenter
    },
    {
      terraform = true
    },
  )
}