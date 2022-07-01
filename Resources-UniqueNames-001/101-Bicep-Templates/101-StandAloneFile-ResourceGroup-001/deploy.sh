# Parameters
RESOURCEGROUPNAME="RG-UniqueName"
LOCATION="westeurope"

# Create the resource group
az group create -n $RESOURCEGROUPNAME -l $LOCATION

# Deploy the bicep template
az deployment group create \
  --resource-group $RESOURCEGROUPNAME \
  --template-file storageAccount.bicep \
  --parameters location=$LOCATION \
               storageAccountName="mysa1"