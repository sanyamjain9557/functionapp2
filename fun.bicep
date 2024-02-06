param location string = 'East US'
module Funapp 'modules/funapp.bicep' = {
  name: 'FunappModule'
  params: {
    appInsightsLocation: location
  }
}
