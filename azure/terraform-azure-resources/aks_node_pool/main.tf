module "resource_group" {
  source  = "app.terraform.io/prismpay/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-node-pool-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

module "aks_cluster_node_pool" {
  source  = "app.terraform.io/prismpay/modules/azure//aks_node_pool"
  version = "1.0.0"

  node_pools  = var.node_pools
  environment = var.environment
  callcenter  = var.callcenter
}