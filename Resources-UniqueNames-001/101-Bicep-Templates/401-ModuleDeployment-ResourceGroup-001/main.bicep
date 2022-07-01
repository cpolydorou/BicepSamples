// ---------- Start - Configuration ----------
targetScope = 'subscription'
// ---------- End - Configuration ------------

// ---------- Start - Parameters -------------
// Deployment location
param location string = 'westeurope' 

// The name of the storage account
param storageAccountName string = 'mysa'

// Resource Group Names
param resourceGroupName string = 'myRG'
// ---------- End - Parameters ---------------

// ---------- Start - Variables --------------
// Create a unique name for the storage account based on the id of the subscription and the name of the resource group
var storageAccountNameFinal = '${storageAccountName}${uniqueString(subscription().id, rgstorage.name)}'
// ---------- End - Variables ----------------

// ---------- Start - ResourceGroups ---------
resource rgstorage 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}
// ---------- End - ResourceGroups -----------

// ---------- Start - Modules ---------
// Deploy the storage account
module storageAccount 'storageAccount.bicep' = {
  name: 'StorageAccount'
  scope: rgstorage
  params: {
    storageAccountName: storageAccountNameFinal
    location: location
  }
}
// ---------- End - Modules -----------

// ---------- Start - Outputs -------------
// ---------- End - Outputs   -------------
