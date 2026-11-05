module "resource_group" {
  source  = "app.terraform.io/prismpay/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-container-registry-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

module "container_registry" {
  source  = "app.terraform.io/prismpay/modules/azure//container_registry"
  version = "1.0.0"

  name                = "${var.environment}${var.project}containerregistry"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku                 = var.sku
  environment         = var.environment
  callcenter          = var.callcenter
}

module "container_registry_webhook" {
  source  = "app.terraform.io/prismpay/modules/azure//container_registry_webhook"
  version = "1.0.0"

  name                = "${var.environment}${var.project}slackchannelwebhook"
  resource_group_name = module.resource_group.name
  registry_name       = module.container_registry.container_registry_name
  location            = module.resource_group.location
  service_uri         = var.service_uri #"https://#{SLACK_WEBHOOK}#"
  status              = var.status
  actions             = var.actions
}