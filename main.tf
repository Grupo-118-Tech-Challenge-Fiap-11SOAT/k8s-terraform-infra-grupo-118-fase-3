module "infra_resource_group" {
  source   = "./modules/azure-resource-group"
  name     = var.resource_group_name
  location = var.resource_group_location
}

output "infra_resource_group_name" {
  value       = module.infra_resource_group.name
  description = "The name of the resource group created by the module"

}

output "infra_resource_group_location" {
  value       = module.infra_resource_group.location
  description = "The location of the resource group created by the module"

}

module "infra_acr" {
  source              = "./modules/azure-container-registry"
  name                = var.acr_name
  location            = module.infra_resource_group.location
  resource_group_name = module.infra_resource_group.name

}

output "infra_acr_name" {
  value       = module.infra_acr.name
  description = "The name of the Azure Container Registry created by the module"

}

output "infra_acr_login_server" {
  value       = module.infra_acr.login_server
  description = "The login server of the Azure Container Registry created by the module"
}

module "infra_vnet_subnets" {
  source              = "./modules/azure-virtual-networks"
  location            = module.infra_resource_group.location
  resource_group_name = module.infra_resource_group.name
}

module "infra_apim" {
  source              = "./modules/azure-api-management"
  apim_name           = var.apim_name
  location            = module.infra_resource_group.location
  resource_group_name = module.infra_resource_group.name
  nsg_name            = var.nsg_name
  subnet_id           = module.infra_vnet_subnets.snet-apim-id
  publisher_email     = var.publisher_email

}