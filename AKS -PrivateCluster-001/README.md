# AKS-PrivateCluster-001
Source files to deploy an Azure AKS cluster with a Private API.

The deployment contains:
* Azure Bicep template files for vNet, AKS, VM and Bastion.

## Deployment
To deploy the environment execute the below steps in sequence.

### AKS Deployment
1. Execute the [101-Bicep-Templates/900-IaC-FullDeployment-001/deploy.sh](https://github.com/cpolydorou/BicepSamples/blob/main/AKS%20-PrivateCluster-001/101-Bicep-Templates/900-IaC-FullDeployment-001/deploy.sh) script to deploy the vNet and AKS. Update the names of the resource groups in the [101-Bicep-Templates/900-IaC-FullDeployment-001/main.bicep](https://github.com/cpolydorou/BicepSamples/blob/main/AKS%20-PrivateCluster-001/101-Bicep-Templates/900-IaC-FullDeployment-001/main.bicep) file.
