// ---------- Start - Parameters -------------
param storageAccountName string = 'sa'
param location string = resourceGroup().location
// ---------- End - Parameters   -------------

// ---------- Start - Variables -------------
var storageAccountNameFinal = toLower('${storageAccountName}${uniqueString(resourceGroup().id)}')
// ---------- End - Variables   -------------

// ---------- Start - Resources -------------
resource storageAccount 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
  name: storageAccountNameFinal
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    networkAcls: {
      resourceAccessRules: []
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
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
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}// ---------- End - Resources   -------------

// ---------- Start - Outputs -------------
// ---------- End - Outputs   -------------
