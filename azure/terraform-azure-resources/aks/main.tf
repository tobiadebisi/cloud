module "resource_group" {
  source  = "app.terraform.io/organization-name/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-${var.local_project}-aks-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

data "azuread_client_config" "current" {}

#module "aad_group" {
#  source  = "app.terraform.io/organization-name/modules/azure//ad_group"
#  version = "1.0.0"

#  display_name = var.display_name
#  owners       = [data.azuread_client_config.current.object_id]
#}

data "azurerm_container_registry" "container_registry" {
  name                = "${var.environment}${var.project}containerregistry"
  resource_group_name = "${var.environment}-${var.project}-container-registry-resource-group"
}

data "azurerm_key_vault" "key_vault" {
  name                = "${var.environment}-${var.project}-key-vault0000"
  resource_group_name = "${var.environment}-${var.project}-key-vault-resource-group"
}

data "azurerm_subnet" "subnet" {
  name                 = "${var.environment}-${var.project}-${var.local_project}-subnet"
  virtual_network_name = "${var.environment}-${var.project}-virtual-network"
  resource_group_name  = "${var.environment}-${var.project}-virtual-network-resource-group"
}

module "aks" {
  source  = "app.terraform.io/organization-name/modules/azure//aks"
  version = "1.0.0"

  name                      = "${var.environment}-${var.project}-${var.local_project}-aks"
  location                  = module.resource_group.location
  resource_group_name       = module.resource_group.name
  dns_prefix                = var.environment
  node_resource_group       = "${var.environment}-${var.project}-${var.local_project}-aks-cluster-node-resource-group"
  kubernetes_version        = var.kubernetes_version
  sku_tier                  = var.sku_tier
  oidc_issuer_enabled       = var.oidc_issuer_enabled
  workload_identity_enabled = var.workload_identity_enabled
  tenant_id                 = var.tenant_id
  admin_group_object_ids    = ["94c839a4-ddb5-47cc-b096-80db9973fa80"] #[module.aad_group.object_id]
  azure_rbac_enabled        = var.azure_rbac_enabled
  vm_size                   = var.vm_size
  vnet_subnet_id            = data.azurerm_subnet.subnet.id
  min_count                 = var.min_count
  max_count                 = var.max_count
  load_balancer_sku         = var.load_balancer_sku
  # dns_service_ip                = var.dns_service_ip
  # docker_bridge_cidr            = var.docker_bridge_cidr
  # service_cidr                  = var.service_cidr
  environment                   = var.environment
  callcenter                    = var.callcenter
  node_public_ip_enabled        = var.node_public_ip_enabled
  drain_timeout_in_minutes      = var.drain_timeout_in_minutes
  max_surge                     = var.max_surge
  node_soak_duration_in_minutes = var.node_soak_duration_in_minutes
  key_data                      = var.key_data
}

#module "aks_metrics_role_assignment" {
#  source  = "app.terraform.io/organization-name/modules/azure//role_assignment"
#  version = "1.0.0"

#  scope                = module.aks.aks_id
#  role_definition_name = "Monitoring Metrics Publisher"
#  principal_id         = module.aks.addon_profile
#}

module "aks_subnet_role_assignment" {
  source  = "app.terraform.io/organization-name/modules/azure//role_assignment"
  version = "1.0.0"

  scope                = data.azurerm_subnet.subnet.id
  role_definition_name = "Network Contributor"
  principal_id         = module.aks.identity
}

module "aks_acr_role_assignment" {
  source  = "app.terraform.io/organization-name/modules/azure//role_assignment"
  version = "1.0.0"

  scope                = data.azurerm_container_registry.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity
}

module "aks_vault_role_assignment" {
  source  = "app.terraform.io/organization-name/modules/azure//role_assignment"
  version = "1.0.0"

  scope                = data.azurerm_key_vault.key_vault.id
  role_definition_name = "Owner"
  principal_id         = module.aks.kubelet_identity
}