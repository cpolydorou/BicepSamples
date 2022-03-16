# Introduction 
Azure Bicep code used to deploy Citrix ADC on a vNet.

The template deploys:
* Resource Groups
* Virtual Network
* Citrix ADC Virtual Machine
* Citrix ADC Public IP
* Citrix ADC Network Security Group

The Citrix ADC is deployed for Bring Your Own License so that you can add your own license.

This is a template to deploy a Citrix ADC for expirimental purposes. When deploying to production make sure you're following all the Landing Zone policies and rules of your organization.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fcpolydorou%2FBicepSamples%2Fmain%2FNetworking-CitrixADC-001%2F900-IaC-FullDeployment-001%2Fmain.json)

<u>Important notice</u></br>
The Network Security Group associate with the Network Interface Card of the machine should be updated right after the deployment
to allow access only from trusted IPs!

<u>Important notice 2</u></br>
Prior to deploying the Citrix ADC, you have to accept the terms for the plan used. Use the "acceptADCPlanTerms.sh" script to accept the terms.