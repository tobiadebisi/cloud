module "resource_group" {
  source  = "app.terraform.io/prismpay/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-virtual-network-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

module "virtual_network" {
  source  = "app.terraform.io/prismpay/modules/azure//virtual_network"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-virtual-network"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  address_space       = var.address_space
  environment         = var.environment
  callcenter          = var.callcenter
}

//--------------------------------------------------------------------------------

module "cardholder_subnet" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_iaas"
  version = "1.0.0"

  name                    = "${var.environment}-${var.project}-cardholder-subnet"
  resource_group_name     = module.resource_group.name
  virtual_network_name    = module.virtual_network.virtual_network_name
  address_prefixes        = var.cardholder_address_prefixes
  service_endpoints       = var.service_endpoints
}

module "cardholder_network_security_group" {
  source  = "app.terraform.io/prismpay/modules/azure//network_security_group"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-network-security-group-cardholder-data-subnet"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  environment         = var.environment
  callcenter          = var.callcenter
  nsg_rule            = var.cardholder_nsg_rule
}


module "cardholder_network_security_group_association" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_network_security_group_association"
  version = "1.0.0"

  subnet_id                 = module.cardholder_subnet.subnet_id
  network_security_group_id = module.cardholder_network_security_group.id
}

//--------------------------------------------------------------------------------

module "internal_subnet" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_iaas"
  version = "1.0.0"

  name                    = "${var.environment}-${var.project}-internal-subnet"
  resource_group_name     = module.resource_group.name
  virtual_network_name    = module.virtual_network.virtual_network_name
  address_prefixes        = var.internal_address_prefixes
  service_endpoints       = var.service_endpoints
}

module "internal_network_security_group" {
  source  = "app.terraform.io/prismpay/modules/azure//network_security_group"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-network-security-group-internal-subnet"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  environment         = var.environment
  callcenter          = var.callcenter
  nsg_rule            = var.internal_nsg_rule
}


module "internal_network_security_group_association" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_network_security_group_association"
  version = "1.0.0"

  subnet_id                 = module.internal_subnet.subnet_id
  network_security_group_id = module.internal_network_security_group.id
}

//--------------------------------------------------------------------------------

module "application_gateway_subnet" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_iaas"
  version = "1.0.0"

  name                    = "${var.environment}-${var.project}-application-gateway-subnet"
  resource_group_name     = module.resource_group.name
  virtual_network_name    = module.virtual_network.virtual_network_name
  address_prefixes        = var.application_gateway_address_prefixes
  service_endpoints       = var.service_endpoints
}

module "application_gateway_network_security_group" {
  source  = "app.terraform.io/prismpay/modules/azure//network_security_group"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-network-security-group-application-gateway-subnet"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  environment         = var.environment
  callcenter          = var.callcenter
  nsg_rule            = var.application_gateway_nsg_rule
}


module "application_gateway_network_security_group_association" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_network_security_group_association"
  version = "1.0.0"

  subnet_id                 = module.application_gateway_subnet.subnet_id
  network_security_group_id = module.application_gateway_network_security_group.id
}

//--------------------------------------------------------------------------------

module "apim_subnet" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_iaas"
  version = "1.0.0"

  name                    = "${var.environment}-${var.project}-apim-subnet"
  resource_group_name     = module.resource_group.name
  virtual_network_name    = module.virtual_network.virtual_network_name
  address_prefixes        = var.apim_address_prefixes
  service_endpoints       = var.service_endpoints
}

module "apim_network_security_group" {
  source  = "app.terraform.io/prismpay/modules/azure//network_security_group"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-network-security-group-apim-subnet"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  environment         = var.environment
  callcenter          = var.callcenter
  nsg_rule            = var.apim_nsg_rule
}


module "apim_network_security_group_association" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_network_security_group_association"
  version = "1.0.0"

  subnet_id                 = module.apim_subnet.subnet_id
  network_security_group_id = module.apim_network_security_group.id
}

//--------------------------------------------------------------------------------

module "mssql_server_subnet" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_iaas"
  version = "1.0.0"

  name                 = "${var.environment}-${var.project}-mssql-server-subnet"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.virtual_network.virtual_network_name
  address_prefixes     = var.mssql_server_address_prefixes
  service_endpoints    = var.mssql_server_service_endpoints #["Microsoft.Sql"]
}

module "mssql_server_network_security_group" {
  source  = "app.terraform.io/prismpay/modules/azure//network_security_group"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-network-security-group-mssql-server-subnet"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  environment         = var.environment
  callcenter          = var.callcenter
  nsg_rule            = var.mssql_server_nsg_rule
}


module "mssql_server_network_security_group_association" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_network_security_group_association"
  version = "1.0.0"

  subnet_id                 = module.mssql_server_subnet.subnet_id
  network_security_group_id = module.mssql_server_network_security_group.id
}

//--------------------------------------------------------------------------------

module "sonarqube_subnet" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_iaas_dynamic"
  version = "1.0.0"

  subnet_variable = var.sonarqube_subnet_variable
}

module "sonarqube_network_security_group" {
  source  = "app.terraform.io/prismpay/modules/azure//network_security_group"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-network-security-group-sonarqube-subnet"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  environment         = var.environment
  callcenter          = var.callcenter
  nsg_rule            = var.sonarqube_nsg_rule
}


module "sonarqube_network_security_group_association" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_network_security_group_association"
  version = "1.0.0"

  for_each = module.sonarqube_subnet.subnet_id

  subnet_id                 = each.value
  network_security_group_id = module.sonarqube_network_security_group.id
}

//--------------------------------------------------------------------------------

module "route_table" {
  source  = "app.terraform.io/prismpay/modules/azure//route_table"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-route-table"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  environment         = var.environment
  callcenter          = var.callcenter
}

module "cardholder_subnet_route_table_association" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_route_table_association"
  version = "1.0.0"

  subnet_id      = module.cardholder_subnet.subnet_id
  route_table_id = module.route_table.id
}

module "internal_subnet_route_table_association" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_route_table_association"
  version = "1.0.0"

  subnet_id      = module.internal_subnet.subnet_id
  route_table_id = module.route_table.id
}

module "application_gateway_subnet_route_table_association" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_route_table_association"
  version = "1.0.0"

  subnet_id      = module.application_gateway_subnet.subnet_id
  route_table_id = module.route_table.id
}

module "apim_subnet_route_table_association" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_route_table_association"
  version = "1.0.0"

  subnet_id      = module.apim_subnet.subnet_id
  route_table_id = module.route_table.id
}

module "mssql_server_subnet_route_table_association" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_route_table_association"
  version = "1.0.0"

  subnet_id      = module.mssql_server_subnet.subnet_id
  route_table_id = module.route_table.id
}

module "sonarqube_subnet_route_table_association" {
  source  = "app.terraform.io/prismpay/modules/azure//subnet_route_table_association"
  version = "1.0.0"

  for_each = module.sonarqube_subnet.subnet_id

  subnet_id      = each.value
  route_table_id = module.route_table.id
}