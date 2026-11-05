module "resource_group" {
  source  = "app.terraform.io/organization-name/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-application-gateway"
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

data "azurerm_subnet" "appgw_subnet" {
  name                 = "${var.environment}-${var.project}-application-gateway-subnet"
  virtual_network_name = "${var.environment}-${var.project}-virtual-network"
  resource_group_name  = "${var.environment}-${var.project}-virtual-network-resource-group"
}

data "azurerm_web_application_firewall_policy" "web_application_firewall_policy" {
  name                = "${var.environment}-${var.project}-web-application-firewall-policy"
  resource_group_name = "${var.environment}-${var.project}-web-application-firewall-policy-resource-group"
}

locals {
  frontend_ip_configuration_name = "appGwPublicFrontendIp"
}

module "public_ip" {
  source  = "app.terraform.io/organization-name/modules/azure//public_ip"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-appgw-public_ip"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  allocation_method   = var.allocation_method
  sku                 = var.public_ip_sku
  environment         = var.environment
  callcenter          = var.callcenter
}

module "application_gateway" {
  source  = "app.terraform.io/organization-name/modules/azure//application_gateway"
  version = "1.0.0"

  name                           = "${var.environment}-${var.project}-application-gateway"
  resource_group_name            = module.resource_group.name
  location                       = module.resource_group.location
  identity_ids                   = [data.azurerm_user_assigned_identity.user_assigned_identity.id]
  appgw_ssl_certificate          = var.appgw_ssl_certificate
  sku_name                       = var.sku_name
  tier                           = var.tier
  firewall_policy_id             = data.azurerm_web_application_firewall_policy.web_application_firewall_policy.id
  gateway_ip_configuration_name  = "${var.environment}${var.project}appGatewayIpConfig"
  subnet_id                      = data.azurerm_subnet.appgw_subnet.id
  frontend_ip_configuration_name = "${var.environment}${var.project}appGwPublicFrontendIp"
  public_ip_address_id           = module.public_ip.public_ip_id
  appgw_backend_address_pool     = var.appgw_backend_address_pool
  appgw_probe                    = var.appgw_probe
  appgw_backend_http_settings    = var.appgw_backend_http_settings
  appgw_http_listener            = var.appgw_http_listener
  appgw_request_routing_rule     = var.appgw_request_routing_rule
  environment                    = var.environment
  callcenter                     = var.callcenter
  ssl_profile-name               = "${var.environment}-${var.project}-appgw-ssl-profile-name"
  policy_type                    = var.policy_type
  policy_name                    = var.policy_name
  min_capacity                   = var.min_capacity
  max_capacity                   = var.max_capacity
}