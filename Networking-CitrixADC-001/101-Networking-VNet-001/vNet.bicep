// Deploy the VNet to connect the Citrix ADC to

// ---------- Start - Parameters -------------
param vNetName string
param location string
// ---------- End - Parameters ---------------

// ---------- Start - Resources --------------
resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vNetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    enableDdosProtection: false
    subnets: [
      {
        name: 'Networking'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'ADC'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}
// ---------- End - Resources ----------------

// ---------- Start - Outputs ----------------
output vNetId string = vnet.id
output vNetName string = vnet.name
// ---------- Start - Outputs ----------------
