// ---------- Start Deployment - Configuration ----------
targetScope='subscription'
// ---------- End Deployment - Configuration   ----------

// ---------- Start - Parameters ----------
// The name of the resource group to place the resources in
param resourceGroupName string

// The location to deploy to
param location string = 'westeurope'
// ---------- End - Parameters   ----------

// ---------- Start - Resources ----------
// Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: resourceGroupName
  location: location
}

// Virtual Network
module vnet 'modules/vnet.bicep' = {
  name: 'VNet'
  scope: rg
  params: {
    vnetName: 'vNet-${uniqueString(rg.id)}'
    vnetPrefix: '10.0.0.0/16'
    location: location
  }
}
// ---------- End - Resources   ----------

// ---------- Start - Outputs ----------
// ---------- End - Outputs   ----------
