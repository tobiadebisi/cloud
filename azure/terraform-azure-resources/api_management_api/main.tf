module "resource_group" {
  source  = "app.terraform.io/organization-name/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.api_project}-api-management-api-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

data "azurerm_resource_group" "resource_group" {
  name = "${var.environment}-${var.project}-apim-resource-group"
}

data "azurerm_api_management" "api_management" {
  name                = "${var.environment}-${var.project}-api-management"
  resource_group_name = "${var.environment}-${var.project}-apim-resource-group"
}

data "http" "swagger" {
  url = var.url
  request_headers = {
    Accept = var.header_accept
  }
}

module "api_management_api" {
  source  = "app.terraform.io/organization-name/modules/azure//api_management_api"
  version = "1.0.0"

  name                = "${var.environment}-${var.api_project}-api-management-api"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  api_management_name = data.azurerm_api_management.api_management.name
  revision            = var.revision
  display_name        = var.display_name
  path                = var.path
  service_url         = var.service_url
  protocols           = var.protocols
  content_format      = var.content_format
  content_value       = data.http.swagger.response_body
}