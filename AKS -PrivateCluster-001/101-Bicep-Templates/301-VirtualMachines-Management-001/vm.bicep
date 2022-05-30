// Create the virtual machine to test the private AKS ingress

// ---------- Start - Parameters -------------
@secure()
param adminUsername string
@secure()
param adminPassword string
param vmName string = 'mgmt'
param location string = 'westeurope'
param subnetId string = ''
// ---------- End - Parameters ---------------

// ---------- Start - Resources --------------
// The network card
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

// The virtual machine
resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
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
}

// Install Tools
resource tools 'Microsoft.Compute/virtualMachines/extensions@2020-06-01' = {
  parent: vm
  name: 'tools-install'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
    settings: {
      skipDos2Unix: false
      fileUris: [
        'https://cpolydorouuni.blob.core.windows.net/scripts/kubectl-install.sh'
        'https://cpolydorouuni.blob.core.windows.net/scripts/azurecli-install.sh'
        'https://cpolydorouuni.blob.core.windows.net/scripts/helm-install.sh'
      ]
    }
    protectedSettings: {
      commandToExecute: 'sh kubectl-install.sh && sh azurecli-install.sh && sh helm-install.sh'
    }
  }
}
// ---------- End - Resources ----------------

// ---------- Start - Outputs ----------------
// ---------- Start - Outputs ----------------