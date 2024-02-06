param storageAccountName string
param location string
param storageAccountType string

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountType
  }
  kind: 'StorageV2'
}

output storageAccountName string = storageAccount.name
output storageAccount string = storageAccount
