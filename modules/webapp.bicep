param webAppName string
param location string
param sku string

var appServicePlanName = 'AppServicePlan-${webAppName}'

resource webappserver 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
  }
}

resource appsite 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: webappserver.id
    siteConfig:{
      netFrameworkVersion: 'v6.0'
    }
  }
}
