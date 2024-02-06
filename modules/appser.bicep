@description('App Service Plan name')
param name string

@description('App Service Plan location')
param location string

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: name
  location: location
  kind: 'functionapp'
  sku: {
    name: 'F1'
  }
}

output planId string = appServicePlan.id
