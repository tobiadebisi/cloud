variable "name" {
  description = "Name of the Diagnostic Setting. Changing this forces a new resource to be created"
  type        = string
}

variable "target_resource_id" {
  description = "ID of an existing Resource on which to configure Diagnostic Settings"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "ID of a Log Analytics Workspace where Diagnostics Data should be sent."
  type        = string
}

variable "log_analytics_destination_type" {
  description = "Possible values are AzureDiagnostics and Dedicated"
  type        = string
}

variable "log_category" {
  description = "The name of a Diagnostic Log Category for this Resource."
  type        = string
}

variable "metric_category" {
  description = "The name of a Diagnostic Metric Category for this Resource."
  type        = string
}