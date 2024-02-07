param appName string = 'fnapp${uniqueString(resourceGroup().id)}'
param location string = 'East US'

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


