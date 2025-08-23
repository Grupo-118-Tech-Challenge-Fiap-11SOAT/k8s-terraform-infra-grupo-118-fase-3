resource "azurerm_kubernetes_cluster" "group118fase3infraaks" {
  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.name
  private_cluster_enabled = true
  private_dns_zone_id     = "System"

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    service_cidr        = "10.10.0.0/16" # Add required service CIDR
    dns_service_ip      = "10.10.0.10"   # Add required DNS service IP    
  }

  default_node_pool {
    name                        = "default"
    temporary_name_for_rotation = "defaulttemp"
    node_count                  = 1
    vm_size                     = "Standard_E2s_v3" # TODO: Procurar tamanhos menores e mudar regiao: Standard_D2s_v3
    os_sku                      = "AzureLinux"
    vnet_subnet_id              = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "terraform_data" "aks-get-credentials" {
  triggers_replace = [
    azurerm_kubernetes_cluster.group118fase3infraaks.id
  ]

  provisioner "local-exec" {
    command = "az aks get-credentials -n ${azurerm_kubernetes_cluster.group118fase3infraaks.name} -g ${azurerm_kubernetes_cluster.group118fase3infraaks.resource_group_name} --overwrite-existing"

  }
}
