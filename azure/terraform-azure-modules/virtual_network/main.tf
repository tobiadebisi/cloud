# Create a virtual network
resource "azurerm_virtual_network" "virtual_network" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space

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
