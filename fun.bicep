param appName string = 'fnapp${uniqueString(resourceGroup().id)}'
param location string = 'East US'
param planName string = appName

module Funapp 'modules/all.bicep' = {
  name: 'FunappModule'
  params: {
    appInsightsLocation: location
    funappName: appName
  }
}

module appServicePlan 'modules/allappser.bicep' = {
  name: 'plandeploy'
  params: {
    hostingPlanName: planName
    location: location
  }
}
