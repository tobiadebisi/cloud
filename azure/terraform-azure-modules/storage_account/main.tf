resource "azurerm_storage_account" "storage_account" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  account_tier               = var.account_tier
  account_replication_type   = var.account_replication_type
  https_traffic_only_enabled = var.https_traffic_only_enabled
  min_tls_version            = var.min_tls_version

  blob_properties {
    #versioning_enabled = true
  }

  tags = merge(
    {
      environment = var.environment
    },
    {
      callcenter = var.callcenter
    },
    {
      terraform = true
    },
  )
}
