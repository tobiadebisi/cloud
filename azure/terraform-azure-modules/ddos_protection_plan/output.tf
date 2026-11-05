output "ddos_protection_plan_id" {
  value       = azurerm_network_ddos_protection_plan.network_ddos_protection_plan.id
  description = "Return the ddos id"
}

output "virtual_network_ids" {
  value       = azurerm_network_ddos_protection_plan.network_ddos_protection_plan.virtual_network_ids
  description = "Return the virtual network id the ddos protection plan is attached to"
}