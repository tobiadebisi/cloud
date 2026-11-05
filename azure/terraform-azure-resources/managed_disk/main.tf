module "resource_group" {
  source  = "app.terraform.io/organization-name/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-managed-disk-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}


module "managed_disk" {
  source  = "app.terraform.io/organization-name/modules/azure//managed_disk"
  version = "1.0.0"

  name                 = "${var.environment}-${var.local_project}-managed-disk"
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.name
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb
  environment          = var.environment
  callcenter           = var.callcenter
}