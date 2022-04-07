// ---------- Start Deployment - Configuration ----------
targetScope='subscription'
// ---------- End Deployment - Configuration   ----------

// ---------- Start - Parameters ----------
// The name of the resource group to place the resources in
param resourceGroupName string

// The location to deploy to
param location string = 'westeurope'

// ---------- End - Parameters   ----------

// ---------- Start - Variables  ----------
// The array of vNets to create
var vnets = [
  {
    name: 'Hub'
    prefix: '10.0.0.0/16'
  }
  {
    name: 'Spoke'
    prefix: '192.168.0.0/24'
  }
]
// ---------- End - Variables   ----------

// ---------- Start - Resources ----------
// Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: resourceGroupName
  location: location
}

// Virtual Networks
module vNetResources 'modules/vnet.bicep' = [for vnet in vnets: {
  name: 'vNet-${vnet.name}'
  scope: rg
  params: {
    vnetName: 'vNet-${vnet.name}-${uniqueString(rg.id)}'
    vnetPrefix: vnet.prefix
    location: location
  }
}]
// ---------- End - Resources   ----------

// ---------- Start - Outputs ----------
output vnets array = [for (vnet, i) in vnets: {
  name: vNetResources[i].outputs.Name
  resourceId: vNetResources[i].outputs.Id
}]
// ---------- End - Outputs   ----------
