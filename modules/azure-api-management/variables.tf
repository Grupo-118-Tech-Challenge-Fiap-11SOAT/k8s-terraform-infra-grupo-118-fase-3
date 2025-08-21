variable "apim_name" {
  description = "The name of the Azure API Management service instance."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the resources will be created."
  type        = string

}

variable "nsg_name" {
  description = "The name of the Network Security Group."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to associate with the NSG."
  type        = string
}

variable "publisher_email" {
  description = "The email address of the API Management publisher."
  type        = string
  default     = "group118@example.com"
}
