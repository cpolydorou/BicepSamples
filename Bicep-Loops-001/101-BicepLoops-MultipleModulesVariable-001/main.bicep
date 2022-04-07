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
// ---------- End - Parameters   ----------

// ---------- Start - Variables ----------
// The array of machines to be created
var vms = [
  {
    name: 'AppServer'
  }
  {
    name: 'DBServer'
  }
]
// ---------- End - Variables   ----------

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
module vm 'modules/vm.bicep' = [for vm in vms: {
  name: vm.name
  scope: rg
  params: {
    location: location
    adminUsername: administratorUsername
    adminPassword: administratorPassword
    vmName: vm.name
    subnetId: '${vnet.outputs.Id}/subnets/default'
  }
}]
// ---------- End - Resources   ----------

// ---------- Start - Outputs ----------
// ---------- End - Outputs   ----------
