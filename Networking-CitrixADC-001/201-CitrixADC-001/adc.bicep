// Deploy the ADC

// ---------- Start - Parameters -------------
param location string = 'westeurope'

param vNetName string
param vNetResourceGroupName string

param ADCName string = 'adc'

param adcSubnetId string
param adcVMSize string = 'Standard_B4ms'

param adminUsername string = 'localadmin'
param adminPassword string
// ---------- End - Parameters -------------

// ---------- Start - References -----------
resource vNet 'Microsoft.Network/virtualNetworks@2020-06-01' existing = {
  name: vNetName
  scope: resourceGroup(vNetResourceGroupName)
}
// ---------- End - References -------------

// ---------- Start - Resources ------------
resource publicIp 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: '${ADCName}-pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: '${ADCName}-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties : {
            protocol : 'Tcp' 
            sourcePortRange :  '*'
            destinationPortRange :  '22'
            sourceAddressPrefix :  '*'
            destinationAddressPrefix: '*'
            access:  'Allow'
            priority : 1010
            direction : 'Inbound'
            sourcePortRanges : []
            destinationPortRanges : []
            sourceAddressPrefixes : []
            destinationAddressPrefixes : []
        }
      }
      {
        name : 'HTTPS'
        properties : {
            protocol :  'Tcp'
            sourcePortRange :  '*'
            destinationPortRange :  '443'
            sourceAddressPrefix :  '*'
            destinationAddressPrefix :  '*'
            access :  'Allow'
            priority : 1020
            direction :  'Inbound'
            sourcePortRanges : []
            destinationPortRanges : []
            sourceAddressPrefixes : []
            destinationAddressPrefixes : []
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: '${ADCName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: adcSubnetId
          }
          publicIPAddress: {
            id: publicIp.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}  

resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: ADCName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: adcVMSize
    }
    osProfile: {
      computerName: ADCName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'citrix'
        offer: 'netscalervpx-131'
        sku: 'netscalerbyol'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ] 
    }
  }
  plan: {
    name: 'netscalerbyol'
    publisher: 'citrix'
    product: 'netscalervpx-131'
  }
}
// ---------- End - Resources -----------

// ---------- Start - Outputs -----------
// ---------- End - Outputs -------------
