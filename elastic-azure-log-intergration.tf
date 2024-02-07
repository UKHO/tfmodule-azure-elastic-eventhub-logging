
resource "null_resource" "create_package_policy" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      curl -X POST "https://${var.ELK_URL}/api/fleet/package_policies" \
-H "Authorization: ApiKey ${var.Elastic_API_Key}" \
-H "Content-Type: application/json" \
-H "kbn-xsrf: reporting" \
-d '{
  "policy_id": "${var.agent_policy_id}",
  "package": {
    "name": "azure",
    "version": "1.7.0"
  },
  "name": "${var.name}-ENG-${var.env}",
  "description": "",
  "namespace": "default",
  "inputs": {
    "eventhub-azure-eventhub": {
      "enabled": true,
      "streams": {
        "azure.eventhub": {
          "enabled": true,
          "vars": {
            "parse_message": false,
            "preserve_original_event": false,
            "data_stream.dataset": "azure.eventhub",
            "tags": [
              "azure-eventhub",
              "forwarded"
            ],
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
    "connection_string": "${local.EVH_ConnectionString}",
    "storage_account": "${var.ELK_storage_account}",
    "storage_account_key": "${var.elkagentstorage-account-key}"
  }
}'
    EOT
  }
}


#resource "null_resource" "create_agent_policy" {
#  triggers = {
#    always_run = timestamp()
#  }
#
#  provisioner "local-exec" {
#    command = <<-EOT
#      curl -k -X POST "https://${var.ELK_URL}/api/fleet/agent_policies?sys_monitoring=true" \
#        -H "Authorization: ApiKey ${var.Elastic_API_Key}" \
#        -H "Content-Type: application/json" \
#        -H "kbn-xsrf: reporting" \
#        -d '{
#          "name": "Agent policy TEST4",
#          "description": "",
#          "namespace": "default",
#          "monitoring_enabled": [
#            "logs",
#            "metrics"
#          ]
#        }'
#    EOT
#  }
#}