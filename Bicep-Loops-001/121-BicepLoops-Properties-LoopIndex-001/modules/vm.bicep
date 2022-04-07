// ---------- Start - Parameters ----------
@secure()
param adminUsername string
@secure()
param adminPassword string
param vmName string = 'winsrv'
param subnetId string = ''
param location string = 'westeurope'
param disks int = 1
// ---------- End - Parameters   ----------

// ---------- Start - Variables ----------
// ---------- End - Variables   ----------

// ---------- Start - Resources ----------
// NIC
resource nic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
}

// Virtual Machine
resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    osProfile: {
      computerName: length(vmName) <= 14 ? vmName : substring(vmName, 0, 14 ) 
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
      dataDisks: [for i in range(1,disks) : {
          diskSizeGB: 64
          lun: i
          name: '${vmName}-DataDisk-${i}'
          createOption: 'Empty'
          managedDisk: {
            storageAccountType: 'Premium_LRS'
          }
        }]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}
// ---------- End - Resources   ----------
