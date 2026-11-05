output "id" {
  value = azurerm_user_assigned_identity.user_assigned_identity.id
}

output "tenant_id" {
  value = azurerm_user_assigned_identity.user_assigned_identity.tenant_id
}

output "client_id" {
  value = azurerm_user_assigned_identity.user_assigned_identity.client_id
}