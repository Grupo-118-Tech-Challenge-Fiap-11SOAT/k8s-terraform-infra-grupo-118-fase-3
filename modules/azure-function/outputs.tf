output "hostname" {
  description = "The hostname of the Azure Function App."
  value       = azurerm_function_app_flex_consumption.azurefunction.default_hostname
}

output "id" {
  description = "The ID of the Azure Function App."
  value       = azurerm_function_app_flex_consumption.azurefunction.id
}