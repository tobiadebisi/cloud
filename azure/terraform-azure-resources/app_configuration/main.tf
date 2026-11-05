module "resource_group" {
  source  = "app.terraform.io/organization-name/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-app-configuration-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

data "azurerm_key_vault" "key_vault" {
  name                = "${var.environment}-${var.project}-key-vault0000"
  resource_group_name = "${var.environment}-${var.project}-key-vault-resource-group"
}

data "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = "${var.environment}-${var.project}-key-vault-assigned-identity"
  resource_group_name = "${var.environment}-${var.project}-key-vault-resource-group"
}

module "app_configuration" {
  source  = "app.terraform.io/organization-name/modules/azure//app_configuration"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-app-configuration"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku                 = var.sku
  identity_ids        = [data.azurerm_user_assigned_identity.user_assigned_identity.id]
  environment         = var.environment
  callcenter          = var.callcenter
}

module "app_configuration_vault_role_assignment" {
  source  = "app.terraform.io/organization-name/modules/azure//role_assignment"
  version = "1.0.0"

  scope                = data.azurerm_key_vault.key_vault.id
  role_definition_name = "Owner"
  principal_id         = module.app_configuration.object_id
}

