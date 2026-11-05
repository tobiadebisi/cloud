resource "azurerm_app_configuration" "app_configuration" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  identity {
    type = "SystemAssigned, UserAssigned"
    identity_ids = var.identity_ids
  }
  tags = merge(
    {
      environment = var.environment
    },
    {
      callcenter = var.callcenter
    },
  )

}