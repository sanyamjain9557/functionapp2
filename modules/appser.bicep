@description('App Service Plan name')
param name string

@description('App Service Plan location')
param location string
var kind = 'functionapp'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: name
  location: location
  sku: {
    name: 'F1'
  }
}

resource functionApp 'Microsoft.Web/sites@2021-03-01' = {
  name: name
  location: location
  kind: kind
  properties: {
    serverFarmId: appServicePlan.id
  }
}

output planId string = appServicePlan.id
