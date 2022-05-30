# Deploy the bicep template

az deployment sub create \
  --name "AKS-PrivateCluster-Demo" \
  --location "westeurope" \
  --template-file main.bicep \
  --parameters location="westeurope" \
               vNetName="vNet" \
               aksClusterName="aks" \
               resourceGroupNamePrefix="RG-AKS-PrivateCluster-" \
               adminUsername="localadmin" \
               adminPassword="Str0ngP@ss"