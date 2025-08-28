#region Resource Group

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
#endregion

#region ACR
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

output "infra_acr_id" {
  value       = module.infra_acr.id
  description = "The ID of the Azure Container Registry created by the module"

}

output "infra_acr_login_server" {
  value       = module.infra_acr.login_server
  description = "The login server of the Azure Container Registry created by the module"
}

output "infra_acr_username" {
  value       = module.infra_acr.username
  description = "The admin username of the Azure Container Registry created by the module"
}

output "infra_acr_password" {
  value       = module.infra_acr.password
  description = "The admin password of the Azure Container Registry created by the module"
  sensitive   = true
}

#endregion

#region VNET and Subnets
module "infra_vnet_subnets" {
  source              = "./modules/azure-virtual-networks"
  location            = module.infra_resource_group.location
  resource_group_name = module.infra_resource_group.name
}
#endregion

#region APIM
module "infra_apim" {
  source              = "./modules/azure-api-management"
  apim_name           = var.apim_name
  location            = module.infra_resource_group.location
  resource_group_name = module.infra_resource_group.name
  nsg_name            = var.nsg_name
  subnet_id           = module.infra_vnet_subnets.snet-apim-id
  publisher_email     = var.publisher_email

}
#endregion

#region AKS

module "infra_aks" {
  source              = "./modules/azure-kubernetes-cluster"
  name                = var.aks_name
  location            = module.infra_resource_group.location
  resource_group_name = module.infra_resource_group.name
  subnet_id           = module.infra_vnet_subnets.snet-aks-id
  acr_id              = module.infra_acr.id

  depends_on = [module.infra_vnet_subnets]
}

resource "kubectl_manifest" "internal_nginx" {
  yaml_body  = <<YAML
apiVersion: approuting.kubernetes.azure.com/v1alpha1
kind: NginxIngressController
metadata:
  name: nginx-internal-static
spec:
  ingressClassName: nginx-internal-static
  controllerNamePrefix: nginx-internal-static
  loadBalancerAnnotations: 
    service.beta.kubernetes.io/azure-load-balancer-internal: "true"
    service.beta.kubernetes.io/azure-load-balancer-ipv4: "10.10.0.10"
YAML
  wait       = true
  depends_on = [module.infra_aks]
}

#endregion
