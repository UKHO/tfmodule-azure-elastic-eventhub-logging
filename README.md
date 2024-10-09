# tfmodule-azure-elastic-eventhub-logging
Use this module to create an eventhub with an associated Elastic Azure Log Integration. 

*NOTE: Currently the Data View must be created manually...*

After this has been run the Elastic policy and data stream will be created.  To create an Elastic Data View using the new data stream you must first push logs to the event hub.  Then the data stream will appear when setting the index pattern for the new Data View.

## Requirements
- `Service` Pass in a service name for the service you want to log. To manage multiple services create multiple references to the module (see usage). 
- `EventHubNameSpace` This module requires an eventhub namespace to be created in your terraform before the module can be called. Ensure you have a depends on within the module to your EventHub Namespace.
- `Azure App Configuration` The module will create two keys in AAC `<service>:EventHubLogging:EntityPath` and `<service::EventHubLogging:EntityPath>`. These are then used to push configure your service to log to the required EventHub.
- `Elastc API Key` You require an API Key with fleet manage permissions to interact with Elastic. 



## Usage 
Create a new file in your terraform repository with naming matching `<service>-api-logging.tf` This allows multiple services within your IaC to use the module from your repository as required. 

```
module "logging" {
  source = "github.com/UKHO/tfmodule-azure-elastic-eventhublogging?ref=1.0"
  providers = {
    azurerm.sub = azurerm.sub
  }
  product_alias                         = ""
  name                                  = ""
  service                               = "" #Keep lower case 
  env                                   = var.environment
  location                              = var.location
  resource_group_name                   = ""
  configuration_store_id                = azurerm_app_configuration.data_hub_appConfig.id
  event_hub_namespace                   = azurerm_eventhub_namespace.this.name
  agent_policy_id                       = var.agent_policy_id
  elk_api_key                           = var.elastic_api_key
  elk_url                               = var.elk_url
  elk_storage_account                   = var.elk_storage_account
  elk_storage_account_key               = var.elk_storage_account_key
  elk_namespace                         = var.elk_namespace # must be lower case 
  using_serilog                         = false # Adds expected keys if set to true and using Serilog, if using UKHO EventHub-Logging-Provider package set it to false

  depends_on = []
  count      = var.enable_evhns ? 1 : 0
}