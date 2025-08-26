output "snet-aks-id" {
  value = azurerm_subnet.snet-aks.id
}

output "snet-apim-id" {
  value = azurerm_subnet.snet-apim.id
}

output "vnet-spoke-id" {
  value = azurerm_virtual_network.vnet-spoke.id
}