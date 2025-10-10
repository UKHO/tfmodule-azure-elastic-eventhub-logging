# tfmodule-azure-elastic-eventhub-logging
Use this module to create an eventhub to use with logging your service

*NOTE: Currently the Data View must be created manually...*

This module on a previous version (1.0.6) used to create the integration via a CURL request but now that side of the automation is done bi-hourly by the observability team.

To create an Elastic Data View using the new data stream you must first push logs to the event hub.  Then the data stream will appear when setting the index pattern for the new Data View.

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
  service                               = "" #Keep lower case 
  env                                   = var.environment
  resource_group_name                   = ""
  configuration_store_id                = azurerm_app_configuration.data_hub_appConfig.id
  event_hub_namespace                   = azurerm_eventhub_namespace.this.name
  using_serilog                         = false # Adds expected keys if set to true and using Serilog, if using UKHO EventHub-Logging-Provider package set it to false

  depends_on = []
  count      = var.enable_evhns ? 1 : 0
}