resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  dns_prefix                = var.environment
  node_resource_group       = var.node_resource_group
  kubernetes_version        = var.kubernetes_version
  sku_tier                  = var.sku_tier
  oidc_issuer_enabled       = var.oidc_issuer_enabled
  workload_identity_enabled = var.workload_identity_enabled

  azure_active_directory_role_based_access_control {
    tenant_id              = var.tenant_id
    admin_group_object_ids = var.admin_group_object_ids
    azure_rbac_enabled     = var.azure_rbac_enabled
  }

  linux_profile {
    admin_username = "ctladmin"
    ssh_key {
      key_data = var.key_data
    }
  }

  default_node_pool {
    name = "agentpool"
    #node_count            = var.node_count
    vm_size                = var.vm_size
    vnet_subnet_id         = var.vnet_subnet_id
    zones                  = [1, 2, 3]
    auto_scaling_enabled   = true
    min_count              = var.min_count
    max_count              = var.max_count
    type                   = "VirtualMachineScaleSets"
    node_public_ip_enabled = var.node_public_ip_enabled
    upgrade_settings {
      drain_timeout_in_minutes      = var.drain_timeout_in_minutes
      max_surge                     = var.max_surge
      node_soak_duration_in_minutes = var.node_soak_duration_in_minutes
    }
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = var.load_balancer_sku
    #dns_service_ip     = var.dns_service_ip
    #docker_bridge_cidr = var.docker_bridge_cidr
    #service_cidr       = var.service_cidr
  }

  identity {
    type = "SystemAssigned"
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
