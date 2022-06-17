// Main bicep file the deploys all resources

// ---------- Start - Configuration ----------
targetScope = 'subscription'
// ---------- End - Configuration ------------

// ---------- Start - Parameters -------------
// Deployment location
param location string = 'westeurope' 

// The name of the application
param appName string = 'app'

// Resource Group Names
param resourceGroupNamePrefix string = 'RG-FD-AppService-'

// Resource names
//param vNetName string = 'vNet'
//param aksClusterName string = 'aks'

// ---------- End - Parameters ---------------

// ---------- Start - Variables --------------
// Create a unique name for the appService
var appNameFinal = '${appName}-${uniqueString(subscription().id)}'

// Create a unique name for the front door
var frontDoorNameFinal = 'fd-${appName}-${uniqueString(subscription().id)}'
// ---------- End - Variables ----------------

// ---------- Start - ResourceGroups ---------
resource rgfd 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupNamePrefix}FrontDoor'
  location: location
}

resource rgapp 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupNamePrefix}AppService'
  location: location
}
// ---------- End - ResourceGroups -----------

// ---------- Start - Modules ---------
// Deploy the AppService
module app '../101-AppService-001/appService.bicep' = {
  name: 'AppService'
  scope: rgapp
  params: {
    webAppName: appNameFinal
    location: location
  }
}

// Deploy the Front Door
module fd '../201-FrontDoor-001/frontDoor.bicep' = {
  name: 'FrontDoor'
  scope: rgfd
  params: {
    frontDoorName: frontDoorNameFinal
    frontDoorEndpointName: appName
    webappURL: app.outputs.webAppURL
  }
}

// ---------- End - Modules -----------

// ---------- Start - Outputs -------------
output appServiceURL string = app.outputs.webAppURL
output frontDoorURL string = fd.outputs.frontDoorURL
// ---------- End - Outputs   -------------
