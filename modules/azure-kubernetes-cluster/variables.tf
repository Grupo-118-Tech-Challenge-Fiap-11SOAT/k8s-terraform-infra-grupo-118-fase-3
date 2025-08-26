variable "name" {
  description = "The name of the AKS cluster."
  type        = string

}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location where the AKS cluster will be created."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the AKS cluster will be deployed."
  type        = string
}

variable "acr_id" {
  description = "The ID of the Azure Container Registry to grant pull access."
  type        = string
}