resource "azurerm_api_management_api" "api_management_api" {
  name                = var.name
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name
  revision            = var.revision
  display_name        = var.display_name
  path                = var.path
  service_url         = var.service_url
  protocols           = var.protocols

  import {
    content_format = var.content_format
    content_value  = var.content_value
  }
}