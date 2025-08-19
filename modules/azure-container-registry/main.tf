resource "azurerm_container_registry" "group118fase3infraacr" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku = var.sku
}