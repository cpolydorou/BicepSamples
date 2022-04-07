# Deploy the template
az deployment sub create --name BicepLoopSample \
                         --location westeurope \
                         --template-file main.bicep \
                         --parameters resourceGroupName=TestBicepLoop