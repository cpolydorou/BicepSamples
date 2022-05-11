# Deploy the bicep template for the ACR

az deployment sub create \
  --name "ACR-Demo" \
  --location "westeurope" \
  --template-file main.bicep \
  --parameters location="westeurope" \
               acrName="acrimage" \
               resourceGroupName="RG-ACRDemo-ACR"