resource "azurerm_container_registry_webhook" "container_registry_webhook" {
  name                = var.name
  resource_group_name = var.resource_group_name
  registry_name       = var.registry_name
  location            = var.location

  service_uri = var.service_uri #"https://#{SLACK_WEBHOOK}#"
  status      = var.status
  actions     = var.actions
  custom_headers = {
    "Content-type" : "application/x-www-form-urlencoded"
  }
}