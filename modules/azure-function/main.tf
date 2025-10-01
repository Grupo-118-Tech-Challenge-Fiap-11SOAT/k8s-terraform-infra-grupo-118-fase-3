resource "azurerm_storage_account" "azurefunctionsa" {
  name                     = "azurefunctionsafase3"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "Storage"
}

resource "azurerm_storage_container" "azurefunctioncontainer" {
  name                  = "azurefunctionsafase3-flexcontainer"
  storage_account_id    = azurerm_storage_account.azurefunctionsa.id
  container_access_type = "private"
}

resource "azurerm_service_plan" "azurefunctionsp" {
  name                = "azurefunctionsafase3-app-service-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.function_os_type
  sku_name            = var.function_sku_name
}

resource "azurerm_function_app_flex_consumption" "azurefunction" {
  name                = "TechChallengeFastFoodFunction"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.azurefunctionsp.id

  storage_container_type      = "blobContainer"
  storage_container_endpoint  = "${azurerm_storage_account.azurefunctionsa.primary_blob_endpoint}${azurerm_storage_container.example.name}"
  storage_authentication_type = "StorageAccountConnectionString"
  storage_access_key          = azurerm_storage_account.azurefunctionsa.primary_access_key
  runtime_name                = "dotnet-isolated"
  runtime_version             = 8.0
  maximum_instance_count      = 50
  instance_memory_in_mb       = 512

  site_config {}

}

