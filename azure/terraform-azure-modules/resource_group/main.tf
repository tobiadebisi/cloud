# Create a resource group
resource "azurerm_resource_group" "resource_group" {
  name     = var.name
  location = var.location

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