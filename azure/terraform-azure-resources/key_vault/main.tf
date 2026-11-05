module "resource_group" {
  source  = "app.terraform.io/prismpay/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-key-vault-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

data "azurerm_client_config" "current" {}

module "key_vault" {
  source  = "app.terraform.io/prismpay/modules/azure//key_vault"
  version = "1.0.0"

  name                        = "${var.environment}-${var.project}-key-vault0000"
  location                    = module.resource_group.location
  resource_group_name         = module.resource_group.name
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  client_config_tenant_id     = module.user_assigned_identity.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled

  sku_name    = var.sku_name
  environment = var.environment
  callcenter  = var.callcenter
}

module "key_vault_access_policy" {
  source  = "app.terraform.io/prismpay/modules/azure//key_vault_access_policy"
  version = "1.0.0"

  key_vault_id            = module.key_vault.id
  client_config_tenant_id = module.user_assigned_identity.tenant_id
  client_config_object_id = module.user_assigned_identity.client_id

  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  storage_permissions     = var.storage_permissions
  certificate_permissions = var.certificate_permissions
}

module "user_assigned_identity" {
  source  = "app.terraform.io/prismpay/modules/azure//user_assigned_identity"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-key-vault-assigned-identity"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "key_vault_role_assignment" {
  source  = "app.terraform.io/prismpay/modules/azure//role_assignment"
  version = "1.0.0"

  scope                = module.key_vault.id
  role_definition_name = var.role_definition_name
  principal_id         = module.user_assigned_identity.client_id
}