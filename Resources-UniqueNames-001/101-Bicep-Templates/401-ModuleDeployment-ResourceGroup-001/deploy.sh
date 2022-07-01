# Parameters
RESOURCEGROUPNAME="RG-UniqueName"
LOCATION="westeurope"

# Deploy the bicep template
az deployment sub create \
  --location $LOCATION \
  --template-file main.bicep \
  --parameters location=$LOCATION \
               resourceGroupName=$RESOURCEGROUPNAME \
               storageAccountName="mysa4"