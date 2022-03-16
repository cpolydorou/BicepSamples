# Deploy the master bicep template

az deployment sub create \
  --name "CitrixADC-Demo" \
  --location "westeurope" \
  --template-file main.bicep \
  --parameters location="westeurope" \
               vNetName="vNet" \
               CitrixADCName="adc"