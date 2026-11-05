resource "azurerm_role_assignment" "role_assignment" {
  role_definition_name             = var.role_definition_name #"Virtual Machine Contributor"
  scope                            = var.scope                #azurerm_resource_group.vnet.id
  principal_id                     = var.principal_id         #azurerm_kubernetes_cluster.privateaks.identity[0].principal_id
  skip_service_principal_aad_check = true
}