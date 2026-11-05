resource "azurerm_api_management" "api_management" {
  name                 = var.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  publisher_name       = var.publisher_name
  publisher_email      = var.publisher_email
  sku_name             = var.sku_name

  virtual_network_type = var.virtual_network_type
  public_ip_address_id = var.public_ip_address_id

  virtual_network_configuration {
    subnet_id = var.subnet_id
  }

  hostname_configuration {
    dynamic "developer_portal" {
      for_each = var.apim_developer_portal
      content {
        host_name                       = developer_portal.value["host_name"]
        key_vault_id                    = developer_portal.value["key_vault_id"]
        negotiate_client_certificate    = developer_portal.value["negotiate_client_certificate"]
        ssl_keyvault_identity_client_id = developer_portal.value["ssl_keyvault_identity_client_id"]
      }
    }

    dynamic "management" {
      for_each = var.apim_management
      content {
        host_name                       = management.value["host_name"]
        key_vault_id                    = management.value["key_vault_id"]
        negotiate_client_certificate    = management.value["negotiate_client_certificate"]
        ssl_keyvault_identity_client_id = management.value["ssl_keyvault_identity_client_id"]
      }
    }

    dynamic "proxy" {
      for_each = var.apim_proxy
      content {
        host_name                       = proxy.value["host_name"]
        key_vault_id                    = proxy.value["key_vault_id"]
        negotiate_client_certificate    = proxy.value["negotiate_client_certificate"]
        ssl_keyvault_identity_client_id = proxy.value["ssl_keyvault_identity_client_id"]
      }
    }
  }

  identity {
    identity_ids = var.identity_ids
    type         = "UserAssigned"
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