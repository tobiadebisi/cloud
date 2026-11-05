module "resource_group" {
  source  = "app.terraform.io/organization-name/modules/azure//resource_group"
  version = "1.0.0"

  name        = "${var.environment}-${var.project}-web-application-firewall-policy-resource-group"
  location    = var.location
  environment = var.environment
  callcenter  = var.callcenter
}

module "web_application_firewall_policy" {
  source  = "app.terraform.io/organization-name/modules/azure//web_application_firewall_policy"
  version = "1.0.0"

  name    = "${var.environment}-${var.project}-web-application-firewall-policy"
  resource_group_name         = module.resource_group.name
  location                    = module.resource_group.location
  enabled                     = var.enabled
  mode                        = var.mode
  request_body_check          = var.request_body_check
  file_upload_limit_in_mb     = var.file_upload_limit_in_mb
  max_request_body_size_in_kb = var.max_request_body_size_in_kb
  managed_rule_set_type       = var.managed_rule_set_type
  managed_rule_set_version    = var.managed_rule_set_version
  custom_rules_name           = "${var.environment}${var.project}customrules"
  priority                    = var.priority
  rule_type                   = var.rule_type
  variable_name               = var.variable_name
  operator                    = var.operator
  negation_condition          = var.negation_condition
  match_values                = var.match_values
  action                      = var.action
}