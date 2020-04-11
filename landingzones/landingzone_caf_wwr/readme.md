# Azure Cloud Adoption Framework WinterWinds 
Welcome to Azure Terraform WinterWinds landing zone: caf_WinterWinds
The foundation landing zone sets the basics of operations, accounting and auditing and security for a subscription, it also sets up what is needed for a COT.

## WinterWinds architecture diagram


## Getting Started

## Log rover into azure

rover login

## Set up the subscription you want to apply resource setting too

az account set --subscription <subscription_GUID>

## set up the foundational things like service provider/terraform state etc.

launchpad /tf/launchpads/launchpad_opensource_light apply
```
## Deploy The WinterWinds landingzone (caf_wwr) 

rover /tf/caf/landingzones/landingzone_caf_wwr plan
```
## Review the configuration and if you are ok with it, deploy it by running: 
```
rover /tf/caf/landingzones/landingzone_caf_foundations apply
```
## to destroy the deployment: 
```
rover /tf/caf/landingzones/landingzone_caf_foundations destroy
```
## The foundations will remain on your subscription so next run, you can jump to step 6 directly. 
More details about the landing zone can be found in the landing zone folder ./landingzone_caf_foundations 

## Update
We recommend you do not update an existing environment directly and should validate a new landing zone release in a separate environment. 

