param appName string = 'fnapp${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location
param appInsightsLocation string
param functionWorkerRuntime string = 'dotnet'

// storageAccount module
module storageAccount 'storageAccount.bicep' = {
  name: 'storageAccount'
  params: {
    storageAccountName: '${uniqueString(resourceGroup().id)}azfunctions'
    location: location
    storageAccountType: 'Standard_LRS'
  }
}
// app server module
module hostingPlan 'hostingPlan.bicep' = {
  name: 'hostingPlan'
  params: {
    appName: appName
    location: location
  }
}
// App insight module
module applicationInsights 'applicationInsights.bicep' = {
  name: 'applicationInsights'
  params: {
    appName: appName
    appInsightsLocation: appInsightsLocation
  }
}

//  functionApp module
module functionApp 'functionApp.bicep' = {
  name: 'functionApp'
  params: {
    functionAppName: appName
    location: location
    hostingPlanName: hostingPlan.outputs.appName
    storageAccountName: storageAccount.outputs.storageAccountName
    appInsightsName: applicationInsights.outputs.appName
    applicationInsights: applicationInsights.outputs.applicationInsights
    functionWorkerRuntime: functionWorkerRuntime
  }
}
