variable "subnet_variable" {
  type = map(object({
    resource_group_name = string
    virtual_network_name = string
    address_prefixes = list(string)
    service_endpoints = optional(list(string), null)
  }))
  description = "A map of subnets without delegation."
}