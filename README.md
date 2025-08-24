# Introduction
Repository to create the Kubernetes infra.

# Create Service Principal
## Replace with your actual subscription ID

```bash
az ad sp create-for-rbac --name "fase3ServicePrincipalInfra" --role Owner --scopes /subscriptions/5359dabe-cccb-424a-b43f-f1b7ec544dc1
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
      version = "=4.4.0"
    }
  }
}
```