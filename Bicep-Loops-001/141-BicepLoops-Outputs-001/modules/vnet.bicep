// ---------- Start - Parameters ----------
param vnetName string = 'vnet'
param vnetPrefix string = '10.0.0.0/16'
param location string = 'westeurope'
// ---------- End - Parameters   ----------

// ---------- Start - Variables  ----------
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
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: vnetPrefix
        }
      }
    ]
  }
}
// ---------- End - Resources   ----------

// ---------- Start - Outputs ----------
output Id string = vnet.id
output Name string = vnet.name
// ---------- End - Outputs   ----------
