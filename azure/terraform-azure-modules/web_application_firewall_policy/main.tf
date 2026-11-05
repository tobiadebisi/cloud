resource "azurerm_web_application_firewall_policy" "web_application_firewall_policy" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  policy_settings {
    enabled                     = var.enabled
    mode                        = var.mode
    request_body_check          = var.request_body_check
    file_upload_limit_in_mb     = var.file_upload_limit_in_mb
    max_request_body_size_in_kb = var.max_request_body_size_in_kb
  }
  managed_rules {
    managed_rule_set {
      type    = var.managed_rule_set_type
      version = var.managed_rule_set_version
    }
    /* 
    exclusion {
      match_variable          = "RequestHeaderNames"
      selector                = "x-company-secret-header"
      selector_match_operator = "Equals"
      excluded_rule_set {
        type = var.excluded_rule_set_type
        version = var.excluded_rule_set_version
        rule_group {
            rule_group_name = var.rule_group_name
            excluded_rules  = var.excluded_rules
        }
      }
    }*/
  }
  custom_rules {
    name      = var.custom_rules_name
    priority  = var.priority
    rule_type = var.rule_type

    match_conditions {
      match_variables {
        variable_name = var.variable_name
      }

      operator           = var.operator
      negation_condition = var.negation_condition
      match_values       = var.match_values
    }

    action = var.action
  }
}