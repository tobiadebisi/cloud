module "resource_group" {
  source  = "app.terraform.io/organization-name/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-mssql-server-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

data "azurerm_subnet" "subnet" {
  name                 = "${var.environment}-${var.project}-mssql-server-subnet"
  virtual_network_name = "${var.environment}-${var.project}-virtual-network"
  resource_group_name  = "${var.environment}-${var.project}-virtual-network-resource-group"
}

module "mssql_virtual_network_rule" {
  source  = "app.terraform.io/organization-name/modules/azure//mssql_virtual_network_rule"
  version = "1.0.0"

  name      = "${var.environment}-${var.project}-mssql-virtual-network-rule"
  server_id = module.mssql_server.id
  subnet_id = data.azurerm_subnet.subnet.id
}

module "mssql_firewall_rule" {
  source  = "app.terraform.io/organization-name/modules/azure//mssql_firewall_rule"
  version = "1.0.0"

  name             = "${var.environment}-${var.project}-mssql-firewall-rule"
  server_id        = module.mssql_server.id
  start_ip_address = var.start_ip_address
  end_ip_address   = var.end_ip_address
}

module "mssql_server" {
  source  = "app.terraform.io/organization-name/modules/azure//mssql_server"
  version = "1.0.0"

  name                          = "${var.environment}-${var.project}-mssql-server-server"
  resource_group_name           = module.resource_group.name
  location                      = module.resource_group.location
  mssql_server_version          = var.mssql_server_version
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled
  connection_policy             = var.connection_policy
  login_username                = var.login_username
  object_id                     = var.object_id
  azuread_authentication_only   = var.azuread_authentication_only
  environment                   = var.environment
  callcenter                    = var.callcenter
}

module "cardholder_mssql_database" {
  source  = "app.terraform.io/organization-name/modules/azure//mssql_database"
  version = "1.0.0"

  name                                = "${var.environment}-${var.sonarqube_project}-database"
  server_id                           = module.mssql_server.id
  collation                           = var.collation
  license_type                        = var.license_type
  read_scale                          = var.read_scale
  sku_name                            = var.sku_name
  zone_redundant                      = var.zone_redundant
  read_replica_count                  = var.read_replica_count
  environment                         = var.environment
  callcenter                          = var.callcenter
  max_size_gb                         = var.max_size_gb
  storage_account_type                = var.storage_account_type
}

module "internal_mssql_database" {
  source  = "app.terraform.io/organization-name/modules/azure//mssql_database"
  version = "1.0.0"

  name                                = "${var.environment}-${var.internal_project}-internal-database"
  server_id                           = module.mssql_server.id
  collation                           = var.collation
  license_type                        = var.license_type
  read_scale                          = var.read_scale
  sku_name                            = var.sku_name
  zone_redundant                      = var.zone_redundant
  read_replica_count                  = var.read_replica_count
  environment                         = var.environment
  callcenter                          = var.callcenter
  max_size_gb                         = var.max_size_gb
  storage_account_type                = var.storage_account_type
}

