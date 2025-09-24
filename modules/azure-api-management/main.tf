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
  publisher_email               = "group118@example.com"
  public_network_access_enabled = true

  virtual_network_configuration {
    subnet_id = var.subnet_id
  }

  depends_on = [azurerm_subnet_network_security_group_association.nsg-association]
}

resource "azurerm_api_management_product" "group118fase3infraapimproduct" {
  product_id            = "${var.apim_name}-product"
  api_management_name   = azurerm_api_management.group118fase3infraapim.name
  resource_group_name   = azurerm_resource_group.group118fase3infrarg.name
  display_name          = "Group 118 Product"
  subscription_required = true
  approval_required     = false
  published             = true
}