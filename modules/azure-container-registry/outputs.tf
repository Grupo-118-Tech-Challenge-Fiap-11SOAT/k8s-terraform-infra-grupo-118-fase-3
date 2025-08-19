output "name" {
  description = "The name of the container registry"
  value       = azurerm_container_registry.group118fase3infraacr.name
}

output "id" {
  description = "The ID of the container registry"
  value       = azurerm_container_registry.group118fase3infraacr.id
}

output "login_server" {
  description = "The login server of the container registry"
  value       = azurerm_container_registry.group118fase3infraacr.login_server
}