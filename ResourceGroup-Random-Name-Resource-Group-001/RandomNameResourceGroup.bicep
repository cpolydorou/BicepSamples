// Create a resource group with a random name based on the subscription ID.

// Set the deployment scope
targetScope = 'subscription'

// Parameters
param location string = 'westeurope'
param resourcePrefix string = 'DevOps-Test'

// Variables
var resourceGroupName = '${resourcePrefix}-${guid(subscription().subscriptionId)}'

// Resources
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

// Outputs
output resourceGroupName string = resourceGroupName
