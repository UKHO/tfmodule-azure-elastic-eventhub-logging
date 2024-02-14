
resource "null_resource" "create_package_policy" {
  triggers = {
    var_eventhub_url = var.elk_url
    var_api_key = var.elk_api_key
    var_policy_id = var.agent_policy_id
    var_name = var.name
    var_service = var.service
    var_env = var.env
    var_event_hub_namespace_connection_string = var.event_hub_namespace_connection_string
    var_elk_storage_account = var.elk_storage_account
    var_elk_storage_account_key = var.elk_storage_account_key
  }
  depends_on = [ azurerm_eventhub.logging ]
   

  provisioner "local-exec" {
    command = <<-EOT
      curl -X POST "https://${var.elk_url}/api/fleet/package_policies" \
-H "Authorization: ApiKey ${var.elk_api_key}" \
-H "Content-Type: application/json" \
-H "kbn-xsrf: reporting" \
-d '{
  "policy_id": "${var.agent_policy_id}",
  "package": {
    "name": "azure",
    "version": "1.7.0"
  },
  "name": "${var.name}-${var.service}-ENG-${var.env}",
  "description": "",
  "namespace": "${var.elk_namespace}",
  "inputs": {
    "eventhub-azure-eventhub": {
      "enabled": true,
      "streams": {
        "azure.eventhub": {
          "enabled": true,
          "vars": {
            "parse_message": true,
            "preserve_original_event": false,
            "data_stream.dataset": "azure.eventhub",
            "tags": [
              "azure-eventhub",
              "forwarded"
            ],
            "processors": "- decode_json_fields:\r\n    fields: [\"message\"]\r\n    target: \"\"\r\n    expand_keys: true\r\n    add_error_key: true",
            "sanitize_newlines": false,
            "sanitize_singlequotes": false
          }
        }
      }
    },
    "adlogs-azure-eventhub": {
      "enabled": false,
      "streams": {
        "azure.auditlogs": {
          "enabled": false,
          "vars": {
            "preserve_original_event": false,
            "tags": [
              "azure-auditlogs",
              "forwarded"
            ],
            "sanitize_newlines": false,
            "sanitize_singlequotes": false
          }
        },
        "azure.identity_protection": {
          "enabled": false,
          "vars": {
            "preserve_original_event": false,
            "tags": [
              "azure-identity-protection-logs",
              "forwarded"
            ],
            "sanitize_newlines": false,
            "sanitize_singlequotes": false
          }
        },
        "azure.provisioning": {
          "enabled": false,
          "vars": {
            "preserve_original_event": false,
            "tags": [
              "azure-provisioning-logs",
              "forwarded"
            ],
            "sanitize_newlines": false,
            "sanitize_singlequotes": false
          }
        },
        "azure.signinlogs": {
          "enabled": false,
          "vars": {
            "tags": [
              "azure-signinlogs",
              "forwarded"
            ],
            "preserve_original_event": false,
            "sanitize_newlines": false,
            "sanitize_singlequotes": false
          }
        }
      }
    },
    "platformlogs-azure-eventhub": {
      "enabled": false,
      "streams": {
        "azure.platformlogs": {
          "enabled": false,
          "vars": {
            "preserve_original_event": false,
            "tags": [
              "azure-platformlogs",
              "forwarded"
            ],
            "sanitize_newlines": false,
            "sanitize_singlequotes": false
          }
        }
      }
    },
    "activitylogs-azure-eventhub": {
      "enabled": false,
      "streams": {
        "azure.activitylogs": {
          "enabled": false,
          "vars": {
            "preserve_original_event": false,
            "tags": [
              "azure-activitylogs",
              "forwarded"
            ],
            "sanitize_newlines": false,
            "sanitize_singlequotes": false
          }
        }
      }
    },
    "springcloudlogs-azure-eventhub": {
      "enabled": false,
      "streams": {
        "azure.springcloudlogs": {
          "enabled": false,
          "vars": {
            "preserve_original_event": false,
            "tags": [
              "azure-springcloudlogs",
              "forwarded"
            ],
            "sanitize_newlines": false,
            "sanitize_singlequotes": false
          }
        }
      }
    },
    "firewall_logs-azure-eventhub": {
      "enabled": false,
      "streams": {
        "azure.firewall_logs": {
          "enabled": false,
          "vars": {
            "preserve_original_event": false,
            "tags": [
              "azure-firewall",
              "forwarded"
            ],
            "sanitize_newlines": false,
            "sanitize_singlequotes": false
          }
        }
      }
    },
    "application_gateway-azure-eventhub": {
      "enabled": false,
      "streams": {
        "azure.application_gateway": {
          "enabled": false,
          "vars": {
            "preserve_original_event": false,
            "tags": [
              "azure-application-gateway-logs",
              "forwarded"
            ],
            "sanitize_newlines": false,
            "sanitize_singlequotes": false
          }
        }
      }
    }
  },
  "vars": {
    "eventhub": "${local.eventhub_name}",
    "consumer_group": "$Default",
    "connection_string": "${local.eventhub_connection_string}",
    "storage_account": "${var.elk_storage_account}",
    "storage_account_key": "${var.elk_storage_account_key}"
  }
}'
    EOT
  }
}
