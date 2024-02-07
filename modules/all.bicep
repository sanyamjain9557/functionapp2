param appName string
param planId string
param storageAccountType string = 'Standard_LRS'
param location string = resourceGroup().location
//param appInsightsLocation string
param runtime string = 'dotnet'
param applicationInsightskey string

var functionAppName = appName
//var hostingPlanName = appName
//var applicationInsightsName = appName
var storageAccountName = '${uniqueString(resourceGroup().id)}azfunctions'
var functionWorkerRuntime = runtime

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountType
  }
  kind: 'Storage'
  properties: {
    supportsHttpsTrafficOnly: true
    defaultToOAuthAuthentication: true
  }
}

//resource hostingPlan 'Microsoft.Web/serverfarms@2021-03-01' = {
//   name: hostingPlanName
//   location: location
//   sku: {
//     name: 'Y1'
//     tier: 'Dynamic'
//   }
//   properties: {}
// }

resource functionApp 'Microsoft.Web/sites@2021-03-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: planId
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(functionAppName)
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: 'v6.0'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: applicationInsightskey
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: functionWorkerRuntime
        }
      ]
      ftpsState: 'FtpsOnly'
      netFrameworkVersion: 'v6.0'
      minTlsVersion: '1.2'
    }
    httpsOnly: true
  }
}

//resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
//  name: applicationInsightsName
//  location: appInsightsLocation
//  kind: 'web'
//  properties: {
//    Application_Type: 'web'
//    Request_Source: 'rest'
//  }
//}
