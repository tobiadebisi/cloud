resource "azurerm_mssql_database" "mssql_database" {
  name                                = var.name
  server_id                           = var.server_id
  collation                           = var.collation
  license_type                        = var.license_type
  read_scale                          = var.read_scale
  sku_name                            = var.sku_name
  zone_redundant                      = var.zone_redundant
  read_replica_count                  = var.read_replica_count
  max_size_gb                         = var.max_size_gb
  storage_account_type                = var.storage_account_type

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