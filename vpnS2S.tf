
resource "azurerm_subnet" "subnet_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["172.16.2.0/24"]
}


resource "azurerm_public_ip" "pub-ip" {
  name                = "vpn-pub-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vnet-gateway" {
  name                = "vpn-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.pub-ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet_gateway.id
  }
}

resource "azurerm_local_network_gateway" "local-gateway" {
  name                = "vpn-local-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name


  gateway_address = var.gateway_address
  address_space   = [var.address_space]
}

resource "azurerm_virtual_network_gateway_connection" "gateway-connection" {
  name                = "site2site_Pfsense"
  resource_group_name = var.resource_group_name
  location            = var.location


  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vnet-gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local-gateway.id

  shared_key = var.shared_key


}
