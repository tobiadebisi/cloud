resource "azurerm_application_gateway" "application_gateway" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  enable_http2        = false
  firewall_policy_id  = var.firewall_policy_id

  identity {
    identity_ids = var.identity_ids
    type         = "UserAssigned"
  }

  dynamic "ssl_certificate" {
    for_each = var.appgw_ssl_certificate
    content {
      name                = ssl_certificate.value["name"]
      key_vault_secret_id = ssl_certificate.value["key_vault_secret_id"]
    }
  }

  sku {
    name = var.sku_name
    tier = var.tier
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_configuration_name
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "port_443"
    port = 443
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = var.public_ip_address_id
  }

  dynamic "backend_address_pool" {
    for_each = var.appgw_backend_address_pool
    content {
      name         = backend_address_pool.value["name"]
      ip_addresses = backend_address_pool.value["ip_addresses"]
    }
  }

  dynamic "probe" {
    for_each = var.appgw_probe
    content {
      name                                      = probe.value["name"]
      host                                      = probe.value["host"]
      path                                      = probe.value["path"]
      pick_host_name_from_backend_http_settings = probe.value["pick_host_name_from_backend_http_settings"]
      protocol                                  = probe.value["protocol"]
      unhealthy_threshold                       = probe.value["unhealthy_threshold"]
      timeout                                   = probe.value["timeout"]
      interval                                  = probe.value["interval"]
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.appgw_backend_http_settings
    content {
      name                                = backend_http_settings.value["name"]
      cookie_based_affinity               = backend_http_settings.value["cookie_based_affinity"]
      path                                = backend_http_settings.value["path"]
      port                                = backend_http_settings.value["port"]
      protocol                            = backend_http_settings.value["protocol"]
      request_timeout                     = backend_http_settings.value["request_timeout"]
      affinity_cookie_name                = backend_http_settings.value["affinity_cookie_name"]
      host_name                           = backend_http_settings.value["host_name"]
      pick_host_name_from_backend_address = backend_http_settings.value["pick_host_name_from_backend_address"]
      probe_name                          = backend_http_settings.value["probe_name"]
    }
  }

  dynamic "http_listener" {
    for_each = var.appgw_http_listener
    content {
      name                           = http_listener.value["name"]
      frontend_ip_configuration_name = http_listener.value["frontend_ip_configuration_name"]
      frontend_port_name             = http_listener.value["frontend_port_name"]
      protocol                       = http_listener.value["protocol"]
      host_name                      = http_listener.value["host_name"]
      require_sni                    = http_listener.value["require_sni"]
      ssl_certificate_name           = http_listener.value["ssl_certificate_name"]
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.appgw_request_routing_rule
    content {
      name                       = request_routing_rule.value["name"]
      priority                   = request_routing_rule.value["priority"]
      rule_type                  = request_routing_rule.value["rule_type"]
      http_listener_name         = request_routing_rule.value["http_listener_name"]
      backend_address_pool_name  = request_routing_rule.value["backend_address_pool_name"]
      backend_http_settings_name = request_routing_rule.value["backend_http_settings_name"]
    }
  }

  ssl_profile {
    name = var.ssl_profile-name
    ssl_policy {
      policy_type = var.policy_type
      policy_name = var.policy_name
    }
  }

  autoscale_configuration {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }
/*
  dynamic "rewrite_rule_set" {
    for_each = var.appgw_rewrite_rule_set
    iterator = "rule_set"
    content {
      name = lookup(rule_set.value, "name")

      dynamic "rewrite_rule" {
        for_each = rule_set.value.rewrite_rule
        iterator = "rule"
        content {
          name = lookup(rule.value, "name", format("%s-%s", lookup(rule_set.value, "name"), lookup(rule.value, "sequence")))
          rule_sequence = lookup(rule.value, "sequence", 100)

          dynamic "response_header_configuration" {
            for_each = lookup(rule.value, "response_header_name", null) != null ? ["dummy"] : []
            content {
              header_name = lookup(rule.value, "response_header_name", "")
              header_value = lookup(rule.value, "response_header_value", "")
            }
          }
        }
      }
    }
  }
*/
  tags = merge(
    {
      environment = var.environment
    },
    {
      callcenter = var.callcenter
    },
    {
      terraform = true
    },
  )
}


