// Create the Front Door resource

// ---------- Start - Parameters -------------
param frontDoorName string
param frontDoorEndpointName string
param webappURL string
// ---------- End - Parameters -------------

// ---------- Start - Resources ------------
resource frontdoor 'Microsoft.Network/frontDoors@2020-05-01' = {
  name: frontDoorName
  location: 'global'
  properties: {
    routingRules: [
      {
        name: 'http'
        properties: {
          frontendEndpoints: [
            {
              id: resourceId('Microsoft.Network/frontDoors/frontendEndpoints', frontDoorName, frontDoorEndpointName)
            }
          ]
          acceptedProtocols: [
            'Http'
            'Https'
          ]
          patternsToMatch: [
            '/*'
          ]
          routeConfiguration: {
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration'
            backendPool: {              
              id:  resourceId('Microsoft.Network/frontDoors/backendPools', frontDoorName, 'appServiceBackendPool')
            }
            forwardingProtocol: 'HttpOnly'
          }
          enabledState: 'Enabled'
        }
      }
    ]
    healthProbeSettings: [
      {
        name: 'healthProbeSettings1'
        properties: {
          path: '/'
          protocol: 'Http'
          intervalInSeconds: 30
        }
      }
    ]
    loadBalancingSettings: [
      {
        name: 'loadBalancingSettings1'
        properties: {
          sampleSize: 4
          successfulSamplesRequired: 2
        }
      }
    ]
    backendPools: [
      {
        name: 'appServiceBackendPool'
        properties: {
          backends: [
            {
              address: webappURL
              backendHostHeader: webappURL
              httpPort: 80
              httpsPort: 443
              weight: 50
              priority: 1
              enabledState: 'Enabled'
            }
          ]
          loadBalancingSettings: {
            id: resourceId('Microsoft.Network/frontDoors/loadBalancingSettings', frontDoorName, 'loadBalancingSettings1')
          }
          healthProbeSettings: {
            id: resourceId('Microsoft.Network/frontDoors/healthProbeSettings', frontDoorName, 'healthProbeSettings1')
          }
        }
      }
    ]
    frontendEndpoints: [
      {
        name: frontDoorEndpointName
        properties: {
          hostName: '${frontDoorName}.azurefd.net'
          sessionAffinityEnabledState: 'Disabled'
        }
      }
    ]
    enabledState: 'Enabled'
  }
}
// ---------- End - Resources   ------------
