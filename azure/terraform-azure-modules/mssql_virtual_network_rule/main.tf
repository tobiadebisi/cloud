resource "azurerm_mssql_virtual_network_rule" "mssql_virtual_network_rule" {
  name      = var.name
  server_id = var.server_id
  subnet_id = var.subnet_id
}