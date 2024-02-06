param name string = 'vis${uniqueString(resourceGroup().id)}'
param location string
param sku string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: name
  location: location
  kind: 'StorageV2'
  sku: {
    name: sku
  }
  properties: {
   accessTier: 'Hot'
   supportsHttpsTrafficOnly: true
   encryption: {
     keySource: 'Microsoft.Storage'
     services: {
       file: {
         keyType: 'Account'
         enabled: true
       }
       blob: {
         keyType: 'Account'
         enabled: true
       }
     }
   }
  }
}

var accountName = storageAccount.name
var endpointSuffix = environment().suffixes.storage
var key = listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value

output storageAccountConnectionString string = 'DefaultEndpointsProtocol=https;AccountName=${accountName};EndpointSuffix=${endpointSuffix};AccountKey=${key}'
