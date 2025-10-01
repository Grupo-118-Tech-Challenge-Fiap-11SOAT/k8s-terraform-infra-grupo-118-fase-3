resource "azurerm_network_security_group" "group118fase3infransg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.group118fase3infransg.id
  
}

resource "azurerm_network_security_rule" "allow-inbound-infra-lb" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.group118fase3infransg.name
  name                        = "allow-inbound-infra-lb"
  access                      = "Allow"
  priority                    = 1000 # between 100 and 4096, must be unique, The lower the priority number, the higher the priority of the rule.
  direction                   = "Inbound"
  protocol                    = "Tcp"               # Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
  source_address_prefix       = "AzureLoadBalancer" # CIDR or source IP range or * to match any IP, Supports Tags like VirtualNetwork, AzureLoadBalancer and Internet.
  source_port_range           = "*"                 # between 0 and 65535 or * to match any
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "6390"
}

resource "azurerm_network_security_rule" "allow-inbound-apim" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.group118fase3infransg.name
  name                        = "allow-inbound-apim"
  access                      = "Allow"
  priority                    = 1010 # between 100 and 4096, must be unique, The lower the priority number, the higher the priority of the rule.
  direction                   = "Inbound"
  protocol                    = "Tcp"           # Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
  source_address_prefix       = "ApiManagement" # CIDR or source IP range or * to match any IP, Supports Tags like VirtualNetwork, AzureLoadBalancer and Internet.
  source_port_range           = "*"             # between 0 and 65535 or * to match any
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "3443"
}

resource "azurerm_network_security_rule" "allow-inbound-internet-http" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.group118fase3infransg.name
  name                        = "allow-inbound-internet-http"
  access                      = "Allow"
  priority                    = 1020 # between 100 and 4096, must be unique, The lower the priority number, the higher the priority of the rule.
  direction                   = "Inbound"
  protocol                    = "Tcp"      # Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
  source_address_prefix       = "Internet" # CIDR or source IP range or * to match any IP, Supports Tags like VirtualNetwork, AzureLoadBalancer and Internet.
  source_port_range           = "*"        # between 0 and 65535 or * to match any
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "80"
}

resource "azurerm_network_security_rule" "allow-inbound-internet-https" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.group118fase3infransg.name
  name                        = "allow-inbound-internet-https"
  access                      = "Allow"
  priority                    = 1030 # between 100 and 4096, must be unique, The lower the priority number, the higher the priority of the rule.
  direction                   = "Inbound"
  protocol                    = "Tcp"      # Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
  source_address_prefix       = "Internet" # CIDR or source IP range or * to match any IP, Supports Tags like VirtualNetwork, AzureLoadBalancer and Internet.
  source_port_range           = "*"        # between 0 and 65535 or * to match any
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "443"
}

resource "azurerm_network_security_rule" "allow-outbound-azuresql" {
  count                       = 1 # enable if using Azure SQL
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.group118fase3infransg.name
  name                        = "allow-outbound-azure-sql"
  access                      = "Allow"
  priority                    = 1030 # between 100 and 4096, must be unique, The lower the priority number, the higher the priority of the rule.
  direction                   = "Outbound"
  protocol                    = "Tcp"            # Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
  source_address_prefix       = "VirtualNetwork" # CIDR or source IP range or * to match any IP, Supports Tags like VirtualNetwork, AzureLoadBalancer and Internet.
  source_port_range           = "*"              # between 0 and 65535 or * to match any
  destination_address_prefix  = "SQL"
  destination_port_range      = "1433"
}


resource "azurerm_network_security_rule" "allow-outbound-storage" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.group118fase3infransg.name
  name                        = "allow-outbound-storage"
  access                      = "Allow"
  priority                    = 1000
  direction                   = "Outbound"
  protocol                    = "Tcp"
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
  destination_address_prefix  = "Storage"
  destination_port_range      = "443"
}

resource "azurerm_network_security_rule" "allow-outbound-keyvault" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.group118fase3infransg.name
  name                        = "allow-outbound-keyvault"
  access                      = "Allow"
  priority                    = 1010
  direction                   = "Outbound"
  protocol                    = "Tcp"
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
  destination_address_prefix  = "AzureKeyVault"
  destination_port_range      = "443"
}

resource "azurerm_network_security_rule" "allow-outbound-eventhub" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.group118fase3infransg.name
  name                        = "allow-outbound-eventhub"
  access                      = "Allow"
  priority                    = 1020
  direction                   = "Outbound"
  protocol                    = "Tcp"
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
  destination_address_prefix  = "EventHub"
  destination_port_ranges     = ["5671", "5672", "443"]
}

resource "azurerm_network_security_rule" "allow-outbound-azuremonitor" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.group118fase3infransg.name
  name                        = "allow-outbound-azuremonitor"
  access                      = "Allow"
  priority                    = 1040
  direction                   = "Outbound"
  protocol                    = "Tcp"
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
  destination_address_prefix  = "AzureMonitor"
  destination_port_range      = "443"
}

resource "azurerm_network_security_rule" "allow-outbound-azureconnectors" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.group118fase3infransg.name
  name                        = "allow-outbound-azureconnectors"
  access                      = "Allow"
  priority                    = 1050
  direction                   = "Outbound"
  protocol                    = "Tcp"
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
  destination_address_prefix  = "AzureConnectors"
  destination_port_ranges     = ["443", "80"]
}

resource "azurerm_api_management" "group118fase3infraapim" {
  name                          = var.apim_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  publisher_name                = "Group118"
  sku_name                      = "Developer_1"
  virtual_network_type          = "External"
  publisher_email               = var.publisher_email
  public_network_access_enabled = true

  virtual_network_configuration {
    subnet_id = var.subnet_id
  }

  sign_up {
    enabled = true
    terms_of_service {
      consent_required = false
      enabled = false
    }
  }

  depends_on = [azurerm_subnet_network_security_group_association.nsg-association]
}

resource "azurerm_api_management_product" "group118fase3infraapimproduct" {
  product_id            = "${var.apim_name}-product"
  api_management_name   = azurerm_api_management.group118fase3infraapim.name
  resource_group_name   = var.resource_group_name
  display_name          = "Group 118 Product"
  description           = "Product for Group 118"
  subscription_required = true
  approval_required     = false
  published             = true
}

// Create a group and associate with the product

resource "azurerm_api_management_group" "group118fase3infraapimgroup" {
  name                = "${var.apim_name}-developer"
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.group118fase3infraapim.name
  display_name        = "${var.apim_name}-Group"
  description         = "This is the ${var.apim_name} management group."
}

resource "azurerm_api_management_product_group" "group118fase3infraapimgroupassociation" {
  product_id          = azurerm_api_management_product.group118fase3infraapimproduct.product_id
  group_name          = azurerm_api_management_group.group118fase3infraapimgroup.name
  api_management_name = azurerm_api_management.group118fase3infraapim.name
  resource_group_name = var.resource_group_name
}

// Create a user for testing purposes and associate with the group

resource "random_password" "apim_user_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_api_management_user" "group118fase3infraapimuser" {
  user_id             = "${var.apim_name}-user1"
  api_management_name = azurerm_api_management.group118fase3infraapim.name
  resource_group_name = var.resource_group_name
  first_name          = "Example"
  last_name           = "User"
  email               = "user1${var.publisher_email}"
  state               = "active"
  password            = random_password.apim_user_password.result
}

resource "azurerm_api_management_group_user" "group118fase3infraapimusergroupassociation" {
  user_id             = azurerm_api_management_user.group118fase3infraapimuser.user_id
  group_name          = azurerm_api_management_group.group118fase3infraapimgroup.name
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.group118fase3infraapim.name
}