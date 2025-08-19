variable "resource_group_name" {
  description = "The name of the resource group where resources will be created"
  type        = string
  default     = "terraform-common-infra-grupo-118-fase-3"
}

variable "resource_group_location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "Brazil South"
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default     = "grupo118fase3infraacr"
}