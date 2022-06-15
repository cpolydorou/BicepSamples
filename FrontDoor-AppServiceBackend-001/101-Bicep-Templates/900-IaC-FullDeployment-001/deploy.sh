# Deploy the bicep template

az deployment sub create \
  --name "FrontDoor-AppService-Demo" \
  --location "westeurope" \
  --template-file main.bicep \
  --parameters location="westeurope" \
               resourceGroupNamePrefix="RG-FD-AppService-" \
               appName="app"