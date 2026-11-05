resource "azurerm_network_security_group" "network_security_group" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.nsg_rule
    content {
      name                       = security_rule.value["name"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      priority                   = security_rule.value["priority"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
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