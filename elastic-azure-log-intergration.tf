resource "null_resource" "run_api" {
  provisioner "local-exec" {
    command = "curl -X POST -H 'Content-Type: application/json' -H 'Authorization: Bearer AUTH_TOKEN' -d '{\"name\": \"Agent policy 6\", \"description\": \"\", \"namespace\": \"default\", \"monitoring_enabled\": [\"logs\", \"metrics\"], \"inactivity_timeout\": 1209600, \"is_protected\": false}' http://${var.ELK_URL}/api/fleet/agent_policies?sys_monitoring=true"
    environment = {
      AGENT_POLICY_ID = var.agent_policy_id
      AUTH_TOKEN = var.Elastic_API_Key
    }
  }
}

resource "null_resource" "run_api2" {
  provisioner "local-exec" {
    command = "curl -X POST -H 'Content-Type: application/json' -d '{\"policy_id\": \"${var.agent_policy_id}\", \"package\": {\"name\": \"azure\", \"version\": \"1.7.0\"}, \"name\": \"azure-1\", \"description\": \"\", \"namespace\": \"default\", \"inputs\": {\"eventhub-azure-eventhub\": {\"enabled\": true, \"streams\": {\"azure.eventhub\": {\"enabled\": true, \"vars\": {\"parse_message\": false, \"preserve_original_event\": false, \"data_stream.dataset\": \"azure.eventhub\", \"tags\": [\"azure-eventhub\", \"forwarded\"], \"sanitize_newlines\": false, \"sanitize_singlequotes\": false}}}}, \"adlogs-azure-eventhub\": {\"enabled\": false, \"streams\": {\"azure.auditlogs\": {\"enabled\": false, \"vars\": {\"preserve_original_event\": false, \"tags\": [\"azure-auditlogs\", \"forwarded\"], \"sanitize_newlines\": false, \"sanitize_singlequotes\": false}}, \"azure.identity_protection\": {\"enabled\": false, \"vars\": {\"preserve_original_event\": false, \"tags\": [\"azure-identity-protection-logs\", \"forwarded\"], \"sanitize_newlines\": false, \"sanitize_singlequotes\": false}}, \"azure.provisioning\": {\"enabled\": false, \"vars\": {\"preserve_original_event\": false, \"tags\": [\"azure-provisioning-logs\", \"forwarded\"], \"sanitize_newlines\": false, \"sanitize_singlequotes\": false}}}}}' http://${var.ELK_URL}/api/fleet/package_policies"
    #environment = {
    #  AGENT_POLICY_ID = var.agent_policy_id
    #}
  }
}
