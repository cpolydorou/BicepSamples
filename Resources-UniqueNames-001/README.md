# Resources-UniqueNames-001
Demos of some of the most popular ways to use the Bicep uniqueString function to create unique names for your resources.

The demos contain:
* Resource Group level deployment of a standalone bicep file, using the id of the resource group to generate the unique name
* Subscription level deployment of a standalone bicep file, using the id of the subscription to generate the unique name
* Resource Group level deployment using modules, using the id of the subscription and the id of the resource group to generate the unique name
* Subscription level deployment using modules and resource groups that are created as part of the deployment, using the id of the subscription and the name of the resource group to generate the unique name

To deploy each of the above, change to the respective folder within 101-Bicep-Templates, and execute the deploy.sh script.
All deployment scripts are configured to use the same resource group, in order to show the diferent names generated by the different combinations in uniqueString. Each storage account name prefix contains a number, to help identify the deployment that created it.