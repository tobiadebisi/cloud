resource "azuread_group" "group" {
  display_name     = var.display_name
  owners           = var.owners
  security_enabled = true
}