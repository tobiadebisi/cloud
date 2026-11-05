module "resource_group" {
  source  = "app.terraform.io/prismpay/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-apim-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

data "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = "${var.environment}-${var.project}-key-vault-assigned-identity"
  resource_group_name = "${var.environment}-${var.project}-key-vault-resource-group"
}

data "azurerm_key_vault" "key_vault" {
  name                = "${var.environment}-${var.project}-key-vault0000"
  resource_group_name = "${var.environment}-${var.project}-key-vault-resource-group"
}

data "azurerm_key_vault_certificate" "key_vault_certificate" {
  name         = var.wildcard_certificate_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_subnet" "subnet" {
  name                 = "${var.environment}-${var.project}-apim-subnet"
  virtual_network_name = "${var.environment}-${var.project}-virtual-network"
  resource_group_name  = "${var.environment}-${var.project}-virtual-network-resource-group"
}

module "apim_public_ip" {
  source  = "app.terraform.io/prismpay/modules/azure//public_ip"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-apim-public_ip"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  allocation_method   = var.apim_allocation_method
  sku                 = var.apim_public_ip_sku
  domain_name_label   = var.apim_domain_name_label
  environment         = var.environment
  callcenter          = var.callcenter
}

module "api_management" {
  source  = "app.terraform.io/prismpay/modules/azure//api_management"
  version = "1.0.0"

  name                  = "${var.environment}-${var.project}-api-management"
  location              = module.resource_group.location
  resource_group_name   = module.resource_group.name
  publisher_name        = var.publisher_name
  publisher_email       = var.publisher_email
  sku_name              = var.sku_name
  virtual_network_type  = var.virtual_network_type
  subnet_id             = data.azurerm_subnet.subnet.id
  environment           = var.environment
  callcenter            = var.callcenter
  identity_ids          = [data.azurerm_user_assigned_identity.user_assigned_identity.id]
  apim_developer_portal = var.apim_developer_portal
  apim_management       = var.apim_management
  apim_proxy            = var.apim_proxy
  public_ip_address_id  = module.apim_public_ip.public_ip_id
}