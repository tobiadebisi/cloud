module "resource_group" {
  source  = "app.terraform.io/organization-name/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-private-dns-zone-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

data "azurerm_virtual_network" "virtual_network" {
  name                = "${var.environment}-${var.project}-virtual-network"
  resource_group_name = "${var.environment}-${var.project}-virtual-network-resource-group"
}

module "private_dns_zone" {
  source  = "app.terraform.io/organization-name/modules/azure//private_dns_zone"
  version = "1.0.0"

  name                = var.domian_name
  resource_group_name = module.resource_group.name
  environment         = var.environment
  callcenter          = var.callcenter
}

module "private_dns_zone_virtual_network_link" {
  source  = "app.terraform.io/organization-name/modules/azure//private_dns_zone_virtual_network_link"
  version = "1.0.0"

  name                  = "${var.environment}-${var.project}-private-dns-zone-virtual-network-link"
  resource_group_name   = module.resource_group.name
  private_dns_zone_name = module.private_dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.virtual_network.id
  environment           = var.environment
  callcenter            = var.callcenter
}

