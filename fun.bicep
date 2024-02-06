param location string = 'East US'
module Funapp 'modules/all.bicep' = {
  name: 'FunappModule'
  params: {
    appInsightsLocation: location
  }
}
