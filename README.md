# Integrate Dynatrace with Azure Devops

Azure Devops provides multiple development collaboration tools. For this Workshop we will be using the following tools to create a high performant, resilient, self- healing pipeline:
*Azure Repos:* Source control repository for the test application. You can read more on Azure Repos [here](https://docs.microsoft.com/en-us/azure/devops/repos/?view=vsts). 
*Azure Pipelines:* Creating CI/CD pipelines for deploying the test application. You can read more on Azure Devops Pipelines [here](https://docs.microsoft.com/en-us/azure/devops/pipelines/index?view=vsts). 

## Additional Utilities – 

**Azure Devops Extension:** Deployed in Azure Marketplace: Contains – 

*Push Deployment to Dynatrace Task –* The task pushes a Deployment event to Dynatrace when a new version of the application is deployed. It uses the Dynatrace events API to publish the details of the Deployment. The event requires URL to the Dynatrace Tenant, API token, Tag Name and Context (Note the Tag needs to be available in Dynatrace for the event to show up).  

*Unbreakable Pipeline Release Gate –* The quality gate is executed to test the quality of the current build in Staging against a Monspec file. In the case that there are no violations the gate succeeds and pushes the code to Production. In case there are reported Violations then the Release Pipeline fails and the code is not deployed to Production. 

**Azure Functions:** There are two functions being deployed:

*Self Healing Function:* This function will redeploy a good build in the event that the bad build has made it to production upon receiving a Performance issue from Dynatrace. 

*Unbreakable Release gate Function:* This is called post deployment from Staging to validate the build
Azure Storage account: Used for storing the monspec file and the pipelineinfo files. 

**Azure Proxy:** Dynatrace Proxy: Utility with Dynatrace cli installed for comparing the Performance information with the monspec file. 

## Pre Requisites
1. Azure Devops Account. You can [get one here](https://azure.microsoft.com/en-ca/services/devops/)
2. Azure Account. You can [get one here](https://azure.microsoft.com/en-us/)
3. Dynatrace Account. [Start your free SaaS trial](https://www.dynatrace.com/trial/)
4. Copy this Github repo to your file system

## Preparation
1. Upload the Monspec files to Azure Storage Account 


## Deployment

## Result


