resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting" {
  name                           = var.name
  target_resource_id             = var.target_resource_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type

  enabled_log {
    category = var.log_category
  }

  enabled_metric {
    category = var.metric_category
  }
}