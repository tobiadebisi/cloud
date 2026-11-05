variable "node_pools" {
  description = "Map of AKS node pools"
  type = map(object({
    name                  = string
    orchestrator_version  = string
    kubernetes_cluster_id = string
    vm_size               = string

    min_count              = number
    max_count              = number
    vnet_subnet_id         = string
    node_public_ip_enabled = bool
    zones                  = list(string)
    node_labels            = map(string)
    node_taints           = optional(list(string))
    auto_scaling_enabled   = bool
    mode                   = string
    os_disk_size_gb        = number

    upgrade_settings = optional(object({
      drain_timeout_in_minutes      = string
      max_surge                     = string
      node_soak_duration_in_minutes = string
    }))
  }))
}

variable "environment" {
  description = "Tag that identify resource's environment"
  type        = string
}

variable "callcenter" {
  description = "Tag that identify resource's owner"
  type        = string
}