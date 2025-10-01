variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the resources will be created."
  type        = string

}

variable "function_os_type" {
  description = "The OS type for the Azure Function."
  type        = string
}

variable "function_sku_name" {
  description = "The SKU name for the Azure Function."
  type        = string
}
