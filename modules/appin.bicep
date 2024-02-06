param appName string
param appInsightsLocation string

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appName
  location: appInsightsLocation
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

output appName string = applicationInsights.name
output applicationInsights object = applicationInsights.properties
