# Random Name Resource Group
Sample Bicep template that creates a resource group based on user input combined with a random GUID string based on the subscription ID.

Sample Deployment Examples
* az deployment sub create --location <deploymentLocation> --template-file RandomNameResourceGroup.bicep
* az deployment sub create --location <deploymentLocation> --template-file RandomNameResourceGroup.bicep --parameters resourcePrefix=<myPrefix>
* az deployment sub create --location <deploymentLocation> --template-file RandomNameResourceGroup.bicep --parameters resourcePrefix=<myPrefix> location=<resourceLocation>

The location specified in the above commands is used to store deployment data and not the resources themselves. To deploy the resources in a specific location use the location bicep parameter as shown in the last example.

Before submitting any deployments make sure you are connected to the right tenant and subscription.
You can login to your Azure tenant using *az login* and select the right subscription using *az account set*.

This is a subscription level deployment, to remove it use the *az deployment sub list* and *az deployment sub delete* commands.