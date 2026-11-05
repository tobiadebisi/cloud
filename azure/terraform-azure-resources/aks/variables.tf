variable "environment" {
  description = "Tag that identify resource's environment"
  type        = string
}

variable "location" {
  type        = string
  description = ""
}

variable "sku_tier" {
  type        = string
  description = ""
}

variable "oidc_issuer_enabled" {
  type        = bool
  description = ""
}

variable "workload_identity_enabled" {
  type        = bool
  description = ""
}

variable "tenant_id" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
}

variable "azure_rbac_enabled" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
}

variable "project" {
  description = "Project name"
}

variable "local_project" {
  description = "Project name"
}

#variable "display_name" {
#  type        = string
#  description = ""
#}

variable "kubernetes_version" {
  type        = string
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
}

variable "vm_size" {
  type        = string
  description = "(Required) The size of the Virtual Machine, such as Standard_DS2_v2"
}

variable "min_count" {
  type        = string
  description = "(Required) The minimum number of nodes which should exist in this Node Pool"
}

variable "max_count" {
  type        = string
  description = "(Required) The maximum number of nodes which should exist in this Node Pool"
}

variable "load_balancer_sku" {
  type        = string
  description = "The SKU of the Load Balancer used for this Kubernetes Cluster"
}

variable "callcenter" {
  type        = string
  description = "Tag that identify resource's owner"
}

variable "node_public_ip_enabled" {
  type        = bool
  description = "The Network Range used by the Kubernetes service"
}

variable "drain_timeout_in_minutes" {
  description = ""
}

variable "max_surge" {
  description = ""
}

variable "node_soak_duration_in_minutes" {
  description = ""
}

variable "key_data" {
  type        = string
  description = ""
}
