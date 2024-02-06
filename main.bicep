@description('Resources location')
param location string = resourceGroup().location
param resname string = 'viskomatsutest1'

//----------- Storage Account Parameters ------------
param storageAccountSku string = 'Standard_LRS'

//----------- Application Insights Parameters ------------
// @description('Application Insights name')
// param applicationInsightsName string = resname

//----------- Function App Parameters ------------
@description('Function App Plan name')
param planName string = resname


@description('Function App name')
param functionAppName string = resname

// @description('Function App runtime')
// @allowed([
//   'dotnet'
//   'node'
//   'python'
//   'java'
// ])
param functionAppRuntime string = 'dotnet'


//----------- Storage Account Deployment ------------
module storageAccountModule 'modules/sa.bicep' = {
  name: 'sadeploy'
  params: {
    sku: storageAccountSku
    location: location
  }
}

//----------- Application Insights Deployment ------------
// module applicationInsightsModule 'modules/appin.bicep' = {
//   name: 'appindeploy'
//   params: {
//     name: applicationInsightsName
//     location: location
//   }
// }

//----------- App Service Plan Deployment ------------
module appServicePlan 'modules/appser.bicep' = {
  name: 'plandeploy'
  params: {
    name: planName
    location: location
  }
}

//----------- Function App Deployment ------------
module functionAppModule 'modules/funapp.bicep' = {
  name: 'funcdeploy'
  params: {
    name: functionAppName
    location: location
    planId: appServicePlan.outputs.planId
    //storageAccountConnectionString: storageAccountModule.outputs.storageAccountConnectionString
    functionAppRuntime: functionAppRuntime
  }
  dependsOn: [
    storageAccountModule
    // applicationInsightsModule
    appServicePlan
  ]
}

//----------- Function App Settings Deployment ------------
// module functionAppSettingsModule 'modules/appsetting.bicep' = {
//   name: 'siteconf'
//   params: {
//     // applicationInsightsKey: applicationInsightsModule.outputs.applicationInsightsKey
//     functionAppName: functionAppModule.outputs.functionAppName
//     functionAppRuntime: functionAppRuntime
//     storageAccountConnectionString: storageAccountModule.outputs.storageAccountConnectionString
//   }
//   dependsOn: [ functionAppModule ]
// }
