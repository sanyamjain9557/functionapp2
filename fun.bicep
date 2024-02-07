param appName string = 'fnapp${uniqueString(resourceGroup().id)}'
param location string = 'East US'

module appServicePlan 'modules/allappser.bicep' = {
  name: 'plandeploy'
  params: {
    hostingPlanName: appName
    location: location
  }
}

module appinsightmodule 'modules/allappser.bicep' = {
  name: 'Insightdeploy'
  params: {
    applicationInsightsName: appName
    appInsightsLocation: location
  }
}

module Funapp 'modules/all.bicep' = {
  name: 'FunappModule'
  params: {
    appInsightsLocation: location
    appName: appName
    planId: appServicePlan.outputs.planId
    applicationInsightskey: appinsightmodule.outputs.applicationInsightskey
  }
}


