resource "azurerm_kubernetes_cluster" "group118fase3infraaks" {
  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.name
  private_cluster_enabled = false

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
  }

  default_node_pool {
    name                        = "default"
    temporary_name_for_rotation = "defaulttemp"
    node_count                  = 1
    vm_size                     = "Standard_E4s_v3" # TODO: Procurar tamanhos menores e mudar regiao: Standard_D2s_v3
    os_sku                      = "AzureLinux"
    vnet_subnet_id              = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  web_app_routing {
    dns_zone_ids = []
  }
}

resource "azurerm_role_assignment" "owner-tocreate-nginx" {
  scope                = var.subnet_id
  role_definition_name = "Owner"
  principal_id         = azurerm_kubernetes_cluster.group118fase3infraaks.identity.0.principal_id

}

resource "terraform_data" "aks-get-credentials" {
  triggers_replace = [
    azurerm_kubernetes_cluster.group118fase3infraaks.id
  ]

  provisioner "local-exec" {
    command = "az aks get-credentials -n ${azurerm_kubernetes_cluster.group118fase3infraaks.name} -g ${azurerm_kubernetes_cluster.group118fase3infraaks.resource_group_name} --overwrite-existing"

  }
}
