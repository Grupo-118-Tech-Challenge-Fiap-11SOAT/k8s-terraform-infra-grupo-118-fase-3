# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "kubectl" {
  host                   = module.infra_aks.host
  cluster_ca_certificate = base64decode(module.infra_aks.cluster_ca_certificate)
  client_certificate     = base64decode(module.infra_aks.client_certificate)
  client_key             = base64decode(module.infra_aks.client_key)
  load_config_file       = false
}

# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.41.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
