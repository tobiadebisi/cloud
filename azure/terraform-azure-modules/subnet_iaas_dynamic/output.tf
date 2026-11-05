output "subnet_id" {
  description = "IDs of the created subnets"
  value       = { for k, v in azurerm_subnet.subnet : k => v.id }
}

output "subnet_name" {
  description = "Names of the created subnets"
  value       = { for k, v in azurerm_subnet.subnet : k => v.name }
}