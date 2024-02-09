param appName string = 'fnapp${uniqueString(resourceGroup().id)}'
param location string = 'East US'
param sku string = 'F1'
param webAppName string = 'webapp${uniqueString(resourceGroup().id)}'

module appServicePlan 'modules/appser.bicep' = {
  name: 'plandeploy'
  params: {
    hostingPlanName: appName
    location: location
  }
}

module appinsightmodule 'modules/appin.bicep' = {
  name: 'Insightdeploy'
  params: {
    applicationInsightsName: appName
    appInsightsLocation: location
  }
}

module Funapp 'modules/funapp.bicep' = {
  name: 'FunappModule'
  params: {
    appName: appName
    planId: appServicePlan.outputs.planId
    applicationInsightskey: appinsightmodule.outputs.applicationInsightskey
  }
}

module Webapp 'modules/webapp.bicep' = {
  name: 'WebappModule'
  params: {
    location: location
    sku: sku
    webAppName: webAppName
  }
}

