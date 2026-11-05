resource "azurerm_network_ddos_protection_plan" "network_ddos_protection_plan" {
  name                = var.network_ddos_protection_plan_name
  location            = var.network_ddos_protection_plan_resource_group_location
  resource_group_name = var.network_ddos_protection_plan_resource_group_name

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