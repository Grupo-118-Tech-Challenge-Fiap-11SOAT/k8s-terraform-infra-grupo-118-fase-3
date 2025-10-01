# Introduction
Repository to create the Kubernetes infra and additional resources (like Azure Function and Apim Users).

# Install Azure CLI

Install the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest&pivots=winget) to authenticate with the FIAP Account. This will allow the service principal creation

# Create Service Principal
## Replace with your actual subscription ID

```bash
az ad sp create-for-rbac --name "fase3ServicePrincipalInfra" --role Owner --scopes /subscriptions/<YOUR_SUBSCRIPTION_ID>
```

Store the generated value in a safe place.

## Configuring secrets
Configure the following variables in repository, as `Repository Secrets` or, if you want to use the same values on other repositories, create `Organization Secrets`

- AZURE_CLIENT_ID
- AZURE_TENANT_ID
- AZURE_SUBSCRIPTION_ID
- AZURE_CLIENT_SECRET

## Create Token on HCP platform

After create the token, you need to consume the value via environment variable

```bash
export TF_TOKEN_app_terraform_io="your-terraform-cloud-token"
```
## Create Environment Variables

To execute the plan locally and store the state on HCP, we need to change the project to execute locally. Also we need to define some environment variables to allow properly communication with Azure RM provider

```bash
export ARM_SUBSCRIPTION_ID="<subscription_id>"
export ARM_CLIENT_ID="<client_id>"
export ARM_CLIENT_SECRET="<client_secret>"
export ARM_TENANT_ID="<tenant_id>"
```

# Backend configuration

```tf
terraform {
  # Configure the backend to use Terraform Cloud
  backend "remote" {
    organization = "<organization_name>"

    workspaces {
      name = "<organization_name>"
    }

  }
}
```

# Provider configuration
```tf
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.41.0"
    }
  }
}
```

# Azure Kubernetes Cluster Connectivity

One of the initial ideas was to create the AKS cluster in a private manner. This way, all traffic would pass through the API Gateway via an internal Load Balancer.
Consulting the [documentation](https://learn.microsoft.com/en-us/azure/aks/private-clusters?tabs=default-basic-networking%2Cazure-portal) and some articles, we identified that accessing the private AKS cluster requires additional resources such as:
 
- Azure Bastion
- VM in the same VNET
- VPN configurations

There are other mechanisms, such as using the [Run Command](https://learn.microsoft.com/en-us/azure/aks/access-private-cluster?tabs=azure-cli) option to invoke commands remotely.

In a corporate scenario, we would have a [VPN](https://learn.microsoft.com/en-us/azure/aks/access-private-cluster?tabs=azure-cli#limitations) to have the IPs configured for access. However, in a study scenario, we don't have this convenience.
