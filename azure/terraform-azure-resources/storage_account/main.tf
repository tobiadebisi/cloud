module "resource_group" {
  source  = "app.terraform.io/prismpay/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-storage-account-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

module "storage_account" {
  source  = "app.terraform.io/prismpay/modules/azure//storage_account"
  version = "1.0.0"

  name                       = "${var.environment}${var.project}storageacct"
  resource_group_name        = module.resource_group.name
  location                   = module.resource_group.location
  account_tier               = var.account_tier
  account_replication_type   = var.account_replication_type
  https_traffic_only_enabled = var.https_traffic_only_enabled
  min_tls_version            = var.min_tls_version
  environment                = var.environment
  callcenter                 = var.callcenter
}

module "storage_container" {
  source  = "app.terraform.io/prismpay/modules/azure//storage_container"
  version = "1.0.0"

  name                  = "${var.environment}${var.project}storagecont"
  storage_account_id  = module.storage_account.id
  container_access_type = var.container_access_type
}