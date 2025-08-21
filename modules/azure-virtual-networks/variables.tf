variable "resource_group_name" {
  description = "The name of the resource group where the container registry will be created."
  type        = string

}

variable "location" {
  description = "The Azure region where the container registry will be created."
  type        = string

}