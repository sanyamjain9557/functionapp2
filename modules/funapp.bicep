@description('Function App name')
param name string

@description('Function App location')
param location string

@description('App Service Plan Id')
param planId string

@description('Storage Account connection string')
@secure()
param storageAccountConnectionString string

param functionAppRuntime string

var kind = 'functionapp'
var function_extension_version = '~4'

resource functionApp 'Microsoft.Web/sites@2021-03-01' = {
  name: name
  location: location
  kind: kind
  properties: {
    serverFarmId: planId
  }
}


resource functionAppSettings 'Microsoft.Web/sites/config@2021-03-01' = {
  parent: functionApp
  name: 'appsettings'
  properties: {
    AzureWebJobsStorage: storageAccountConnectionString
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING: storageAccountConnectionString
    WEBSITE_CONTENTSHARE: toLower(name)
    FUNCTIONS_EXTENSION_VERSION: function_extension_version
    //APPINSIGHTS_INSTRUMENTATIONKEY: applicationInsightsKey
    FUNCTIONS_WORKER_RUNTIME: functionAppRuntime
    //WEBSITE_TIME_ZONE only available on windows
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG: '1'
  }
}


output functionAppName string = functionApp.name
output principalId string = functionApp.identity.principalId
output tenantId string = functionApp.identity.tenantId
