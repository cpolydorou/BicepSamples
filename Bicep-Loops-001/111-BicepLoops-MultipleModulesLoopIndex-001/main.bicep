// ---------- Start Deployment - Configuration ----------
targetScope='subscription'
// ---------- End Deployment - Configuration   ----------

// ---------- Start - Parameters ----------
// The name of the resource group to place the resources in
param resourceGroupName string

// The location to deploy to
param location string = 'westeurope'

// The credentials for the virtual machines
@secure()
param administratorUsername string
@secure()
param administratorPassword string

// The number of machines to deploy
param count int = 1
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

// Virtual Machines
module vm 'modules/vm.bicep' = [for i in range(1,count): {
  name: 'VM-${i}'
  scope: rg
  params: {
    location: location
    adminUsername: administratorUsername
    adminPassword: administratorPassword
    vmName: 'Server-${i}'
    subnetId: '${vnet.outputs.Id}/subnets/default'
  }
}]
// ---------- End - Resources   ----------

// ---------- Start - Outputs ----------
// ---------- End - Outputs   ----------
