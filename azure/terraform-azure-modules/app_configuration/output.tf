output "id" {
  value = azurerm_app_configuration.app_configuration.id
}

output "object_id" {
  value = azurerm_app_configuration.app_configuration.identity.0.principal_id
}