// ---------- Start - Parameters -------------
// Deployment location
param location string = 'westeurope' 

// The name of the application
param storageAccountName string = 'mysa'
// ---------- End - Parameters ---------------

// ---------- Start - Variables --------------
// Create a unique name for the storage account based on the name of the id of the subscription and the id of the resource group
var storageAccountNameFinal = toLower('${storageAccountName}${uniqueString(subscription().id, resourceGroup().id)}')
// ---------- End - Variables   -------------

// ---------- Start - Modules ---------
// Deploy the storage account
module storageAccount 'storageAccount.bicep' = {
  name: 'StorageAccount'
  params: {
    storageAccountName: storageAccountNameFinal
    location: location
  }
}
// ---------- End - Modules -----------

// ---------- Start - Outputs -------------
// ---------- End - Outputs   -------------
