variable "name" {
  description = "(Required) The name of the Managed Kubernetes Cluster to create"
}

variable "location" {
  description = "(Required) The location where the Managed Kubernetes Cluster should be created"
}

variable "resource_group_name" {
  description = "(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist"
}

variable "dns_prefix" {
  description = ""
}

variable "node_resource_group" {
  description = "The name of the Resource Group where the Kubernetes Nodes should exist"
}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
}

variable "sku_tier" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
}

variable "oidc_issuer_enabled" {
  description = "Enable or Disable the OIDC issuer URL"
}

variable "workload_identity_enabled" {
  description = "Enabled Azure AD Workload Identity for the Cluster"
}

variable "tenant_id" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
}

variable "admin_group_object_ids" {
  type        = list(any)
  description = "value"
}

variable "azure_rbac_enabled" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
}

variable "key_data" {
  type        = string
  description = ""
}

variable "vnet_subnet_id" {
  description = "The ID of the subnet on which to create an Application Gateway"
}

variable "vm_size" {
  description = "(Required) The size of the Virtual Machine, such as Standard_DS2_v2"
}

variable "min_count" {
  description = "(Required) The minimum number of nodes which should exist in this Node Pool"
}

variable "max_count" {
  description = "(Required) The maximum number of nodes which should exist in this Node Pool"
}

variable "load_balancer_sku" {
  description = "The SKU of the Load Balancer used for this Kubernetes Cluster"
}

variable "node_public_ip_enabled" {
  description = "The Network Range used by the Kubernetes service"
}

variable "drain_timeout_in_minutes" {
  description = "The Network Range used by the Kubernetes service"
}

variable "max_surge" {
  description = "The Network Range used by the Kubernetes service"
}

variable "node_soak_duration_in_minutes" {
  description = "The Network Range used by the Kubernetes service"
}

variable "environment" {
  description = "Tag that identify resource's environment"
  type        = string
}

variable "callcenter" {
  description = "Tag that identify resource's owner"
  type        = string
}