module "resource_group" {
  source  = "app.terraform.io/organization-name/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-servicebus-namespace-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

module "servicebus_namespace" {
  source  = "app.terraform.io/organization-name/modules/azure//servicebus_namespace"
  version = "1.0.0"

  name                = "${var.environment}-${var.project}-servicebus-namespace"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  sku                 = var.sku
  environment         = var.environment
  callcenter          = var.callcenter
}