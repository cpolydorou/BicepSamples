# FrontDoor-AppServiceBackend-001
Source files to deploy an Azure AppService protected by Azure Front Door.

The deployment contains:
* Azure Bicep template files for AppService, Plan and Front Door.

## Deployment
To deploy the environment follow the below steps:

1. Log in to Azure CLI and select the proper subscription.
2. Execute the [101-Bicep-Templates/900-IaC-FullDeployment-001/deploy.sh](https://github.com/cpolydorou/BicepSamples/blob/main/AKS%20-PrivateCluster-001/101-Bicep-Templates/900-IaC-FullDeployment-001/deploy.sh) script to deploy the AppService and FrontDoor. Update the names of the resource groups in the [101-Bicep-Templates/900-IaC-FullDeployment-001/main.bicep](https://github.com/cpolydorou/BicepSamples/blob/main/AKS%20-PrivateCluster-001/101-Bicep-Templates/900-IaC-FullDeployment-001/main.bicep) file.

## Blog
I've posted a post on the details of the deployment, available [here](https://blog.cpolydorou.net/2022/06/protecting-appservice-using-front-door.html).

## Deployment Status
![Build Status](https://vsrm.dev.azure.com/christospolydorou/_apis/public/Release/badge/a8001c7b-70d1-4fd4-b4b5-ab1a8bbbc570/6/6)

## Deploy to Azure
[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://raw.githubusercontent.com/cpolydorou/BicepSamples/main/FrontDoor-AppServiceBackend-001/101-Bicep-Templates/900-IaC-FullDeployment-001/main.json)