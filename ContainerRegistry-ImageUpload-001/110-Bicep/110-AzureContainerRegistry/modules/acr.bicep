// Create the Container Registry

// ---------- Start - Parameters -------------
param name string = 'acr'
param location string = 'westeurope'
param acrSku string = 'Basic'
// ---------- End - Parameters -------------

// ---------- Start - Variables -------------
// ---------- End - Variables   -------------

// ---------- Start - References -----------
// ---------- End - References -------------

// ---------- Start - Resources ------------
resource acr 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: name
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: true // Using admin access to avoid RBAC complexity
  }
}
// ---------- End - Resources -----------

// ---------- Start - Outputs -----------
output name string = name
output loginServer string = acr.properties.loginServer
output username string = acr.listCredentials().username           // Should not output credentials
output password string = acr.listCredentials().passwords[0].value // Should not output credentials
// ---------- End - Outputs -------------

