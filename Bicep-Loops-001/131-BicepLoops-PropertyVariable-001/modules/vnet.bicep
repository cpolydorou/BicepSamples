// ---------- Start - Parameters ----------
param vnetName string = 'vnet'
param vnetPrefix string = '10.0.0.0/16'
param location string = 'westeurope'
// ---------- End - Parameters   ----------

// ---------- Start - Variables  ----------
// A variable that contains the names of the subnets
var subnets = [
  'Networking'
  'AzureBastionSubnet'
  'Application'
  'Database'
]

// The variable we construct that contains the information
// for all subnets
var subnetsArray = [for (name, i) in subnets: {
  name: 'Subnet-${i}-${name}'
  properties:{
    addressPrefix: '10.0.${i}.0/24'
  }
}]
// ---------- End - Variables   ----------

// ---------- Start - Resources ----------
// Virtual Network
resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: vnetName
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        vnetPrefix
      ]
    }
    subnets: subnetsArray  // The entire subnets configuration is in the variable
  }
}
// ---------- End - Resources   ----------

// ---------- Start - Outputs ----------
output Id string = vnet.id
// ---------- End - Outputs   ----------
