module "resource_group" {
  source  = "app.terraform.io/prismpay/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-postgresql-flexible-server-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

data "azurerm_subnet" "subnet" {
  name                 = "${var.environment}-${var.project}-postgresql-subnet"
  virtual_network_name = "${var.environment}-${var.project}-virtual-network"
  resource_group_name  = "${var.environment}-${var.project}-virtual-network-resource-group"
}

data "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.postgresql_domian_name
  resource_group_name = "${var.environment}-${var.project}-private-dns-zone-resource-group"
}

module "postgresql_flexible_server" {
  source  = "app.terraform.io/prismpay/modules/azure//postgresql_flexible_server"
  version = "1.0.0"

  name                   = var.name
  resource_group_name    = module.resource_group.name
  location               = module.resource_group.location
  postgresql_version     = var.postgresql_version
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  backup_retention_days  = var.backup_retention_days
  delegated_subnet_id    = data.azurerm_subnet.subnet.id
  private_dns_zone_id    = data.azurerm_private_dns_zone.private_dns_zone.id
  sku_name               = var.sku_name
  zone                   = var.zone
  storage_mb             = var.storage_mb
}

module "postgresql_flexible_server_firewall_rule" {
  source  = "app.terraform.io/prismpay/modules/azure//postgresql_flexible_server_firewall_rule"
  version = "1.0.0"

  name             = "${var.environment}-${var.project}-postgresql-flexible-server-firewall-rule"
  server_id        = module.postgresql_flexible_server.id
  start_ip_address = var.start_ip_address
  end_ip_address   = var.end_ip_address
}