// Main bicep file the deploys all required resources

// ---------- Start - Configuration ----------
targetScope = 'subscription'
// ---------- End - Configuration ------------

// ---------- Start - Parameters -------------
// Deployment location
param location string = 'westeurope' 

// Resource Group Names
param resourceGroupName string = 'RG-Test'

// Resource names
param acrName string = 'acr'
// ---------- End - Parameters ---------------

// ---------- Start - Variables --------------
var acrNameFinal = '${acrName}${uniqueString(subscription().id)}'
// ---------- End - Variables ----------------

// ---------- Start - ResourceGroups ---------
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}
// ---------- End - ResourceGroups -----------

// ---------- Start - Modules ---------
// Deploy the Container Registry
module acr './modules/acr.bicep' = {
  name: 'acr'
  scope: rg
  params: {
    name: '${acrNameFinal}acr'
    location: location
  }
}
// ---------- End - Modules -----------

// ---------- Start - Outputs -----------
output acrName string = acrNameFinal
output acrLoginServer string = acr.outputs.loginServer
output acrUsername string = acr.outputs.username // Should not output credentials
output acrPassword string = acr.outputs.password // Should not output credentials
// ---------- End - Outputs -------------

