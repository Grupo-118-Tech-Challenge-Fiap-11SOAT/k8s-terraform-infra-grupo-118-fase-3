resource "azurerm_kubernetes_cluster" "group118fase3infraaks" {
  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.name
  private_cluster_enabled = false
  sku_tier                = "Free"

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
  }

  default_node_pool {
    name                        = "default"
    temporary_name_for_rotation = "defaulttemp"
    node_count                  = 1
    vm_size                     = "Standard_A4_v2" # TODO: Procurar tamanhos menores e mudar regiao: Standard_D2s_v3
    os_sku                      = "AzureLinux"
    vnet_subnet_id              = var.subnet_id
    auto_scaling_enabled        = false
    zones                       = []
  }

  identity {
    type = "SystemAssigned"
  }

  web_app_routing {
    dns_zone_ids             = []
  }
}

resource "azurerm_role_assignment" "owner-tocreate-nginx" {
  scope                = var.subnet_id
  role_definition_name = "Owner"
  principal_id         = azurerm_kubernetes_cluster.group118fase3infraaks.identity.0.principal_id

}

resource "azurerm_role_assignment" "acr-pull" {
  principal_id                     = azurerm_kubernetes_cluster.group118fase3infraaks.identity.0.principal_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}
