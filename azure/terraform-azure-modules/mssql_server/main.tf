resource "azurerm_mssql_server" "mssql_server" {
  name                                 = var.name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  version                              = var.mssql_server_version
  administrator_login                  = var.administrator_login
  administrator_login_password         = var.administrator_login_password
  minimum_tls_version                  = var.minimum_tls_version
  public_network_access_enabled        = var.public_network_access_enabled
  connection_policy                    = var.connection_policy

  identity {
    type = "SystemAssigned"
  }
  azuread_administrator {
    login_username              = var.login_username
    object_id                   = var.object_id
    azuread_authentication_only = var.azuread_authentication_only
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