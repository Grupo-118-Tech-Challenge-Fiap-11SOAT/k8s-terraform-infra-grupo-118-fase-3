output "password" {
  description = "The admin password for the Azure API Management user."
  value       = random_password.apim_user_password.result
}

output "email" {
  value = azurerm_api_management_user.group118fase3infraapimuser.email
  description = "The email of the Azure API Management user."
}