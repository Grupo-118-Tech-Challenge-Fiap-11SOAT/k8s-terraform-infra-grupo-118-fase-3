output "name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.group118fase3infraaks.name
}

output "id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.group118fase3infraaks.id
}

output "kube_config_raw" {
  description = "The raw kube config of the AKS cluster."
  value       = azurerm_kubernetes_cluster.group118fase3infraaks.kube_config_raw

}

output "client_certificate" {
  description = "The client certificate of the AKS cluster."
  value       = azurerm_kubernetes_cluster.group118fase3infraaks.kube_config.0.client_certificate
}

output "client_key" {
  description = "The client key of the AKS cluster."
  value       = azurerm_kubernetes_cluster.group118fase3infraaks.kube_config.0.client_key
}

output "cluster_ca_certificate" {
  description = "The cluster CA certificate of the AKS cluster."
  value       = azurerm_kubernetes_cluster.group118fase3infraaks.kube_config.0.cluster_ca_certificate
}

output "host" {
  description = "The host of the AKS cluster."
  value       = azurerm_kubernetes_cluster.group118fase3infraaks.kube_config.0.host
}