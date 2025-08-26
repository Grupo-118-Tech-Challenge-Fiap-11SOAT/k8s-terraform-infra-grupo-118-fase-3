variable "resource_group_name" {
  description = "The name of the resource group where resources will be created"
  type        = string
  default     = "terraform-common-infra-grupo-118-fase-3"
}

variable "resource_group_location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default     = "grupo118fase3infraacr"
}

variable "apim_name" {
  description = "The name of the Azure API Management service instance"
  type        = string
  default     = "grupo118fase3infraapim"
}

variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
  default     = "grupo118fase3infransg"
}

variable "publisher_email" {
  description = "The email address of the API Management publisher"
  type        = string
  default     = "group118@example.com"
}

variable "aks_name" {
  description = "The name of the AKS cluster"
  type        = string
  default     = "grupo118fase3infraaks"
}