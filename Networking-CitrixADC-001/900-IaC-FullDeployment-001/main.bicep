// Main bicep file the deploys all resources

// ---------- Start - Configuration ----------
targetScope = 'subscription'
// ---------- End - Configuration ------------

// ---------- Start - Parameters -------------
// Deployment location
param location string = 'westeurope' 

// Administrator Credentials
@secure()
param administratorUsername string
@secure()
param administratorPassword string

// Resource names
param vNetName string = 'vNet'
param CitrixADCName string = 'adc'
// ---------- End - Parameters ---------------

// ---------- Start - Variables --------------
var resourceGroupNamePrefix = 'RG-CitrixADC-'
// ---------- End - Variables ----------------

// ---------- Start - ResourceGroups ---------
resource rgnetworking 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupNamePrefix}Networking'
  location: location
}

resource rgadc 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupNamePrefix}ADC'
  location: location
}
// ---------- End - ResourceGroups -----------

// ---------- Start - Modules ---------
// Deploy the virtual network
module vNet '../101-Networking-VNet-001/vNet.bicep' = {
  name: 'vNet'
  scope: rgnetworking
  params: {
    vNetName: vNetName
    location: location
  }
}

// Deploy the ADC
module adc '../201-CitrixADC-001/adc.bicep' = {
  name: 'ADC'
  scope: rgadc
  params: {
    ADCName: CitrixADCName
    location: location
    vNetName: vNet.outputs.vNetName
    vNetResourceGroupName: rgnetworking.name
    adcSubnetId:'${vNet.outputs.vNetId}/subnets/ADC'
    adcVMSize: 'Standard_B4ms'
    adminUsername: administratorUsername
    adminPassword: administratorPassword
  }
  dependsOn: [
    vNet
  ]
}
// ---------- End - Modules -----------
