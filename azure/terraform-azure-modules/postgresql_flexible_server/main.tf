resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.postgresql_version
  delegated_subnet_id    = var.delegated_subnet_id
  private_dns_zone_id    = var.private_dns_zone_id
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  backup_retention_days  = var.backup_retention_days
  zone                   = var.zone

  storage_mb = var.storage_mb

  sku_name = var.sku_name
}