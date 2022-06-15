// Create the app service and plan

// ---------- Start - Parameters -------------
param webAppName string = 'app'                                             // Generate unique String for web app name
param sku string = 'F1'                                                     // The SKU of App Service Plan
param linuxFxVersion string = 'DOCKER|cpolydorou/requestinformation:latest' // The container to use
param location string = resourceGroup().location                            // Location for all resources
// ---------- End - Parameters   -------------

// ---------- Start - Variables -------------
var appServicePlanName = toLower('AppServicePlan-${webAppName}')            // Form a name for the plan
var webSiteName = toLower(webAppName)                                       // Convert the name of the site to lowercase
var dockerRegistryUrl = 'https://index.docker.io'                           // Set the URL for docker hub
// ---------- End - Variables   -------------

// ---------- Start - Resources -------------
resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {          // Deploy the appService plan
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
}

resource appService 'Microsoft.Web/sites@2020-06-01' = {                    // Deploy the appService
  name: webSiteName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      appSettings: [
        {
            name: 'DOCKER_REGISTRY_SERVER_URL'
            value: dockerRegistryUrl
        }
        {
            name: 'DOCKER_REGISTRY_SERVER_USERNAME'
            value: ''
        }
        {
            name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
            value: null
        }
        {
            name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
            value: 'false'
        }
        {
          name: 'PORT'
          value: '8080'
      }
    ]
    }
  }
}
// ---------- End - Resources   -------------

// ---------- Start - Outputs -------------
output webAppURL string = appService.properties.defaultHostName
// ---------- End - Outputs   -------------
