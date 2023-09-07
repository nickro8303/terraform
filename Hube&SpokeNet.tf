
resource "azurerm_resource_group" "rg-hub" {
  name     = "rg-prod-hub-network"
  location = "East US"
  provider = azurerm.Prod
}

resource "azurerm_virtual_network" "vnet-hub" {
  name                = "vnet-hub"
  resource_group_name = azurerm_resource_group.rg-hub.name
  location            = azurerm_resource_group.rg-hub.location
  address_space       = ["172.16.0.0/20"]
  provider            = azurerm.Prod

}

resource "azurerm_subnet" "subnethub" {
  name                 = "subnet-hub"
  resource_group_name  = azurerm_resource_group.rg-hub.name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = ["172.16.1.0/24"]
  provider             = azurerm.Prod
}

resource "azurerm_resource_group" "rg-dev" {
  name     = "rg-dev-network"
  location = "East US"
  provider = azurerm.Dev
}

resource "azurerm_virtual_network" "spoke1" {
  name                = "vnet-dev-spoke-001"
  resource_group_name = azurerm_resource_group.rg-dev.name
  location            = azurerm_resource_group.rg-dev.location
  address_space       = ["172.17.0.0/20"]
  provider            = azurerm.Dev

}

resource "azurerm_subnet" "subnet-dev" {
  name                 = "subnet-dev-001"
  resource_group_name  = azurerm_resource_group.rg-dev.name
  virtual_network_name = azurerm_virtual_network.spoke1.name
  address_prefixes     = ["172.17.1.0/24"]
  provider             = azurerm.Dev
}

resource "azurerm_resource_group" "rg-test" {
  name     = "rg-test-network"
  location = "East US"
  provider = azurerm.Test
}

resource "azurerm_virtual_network" "spoke2" {
  name                = "vnet-test-spoke-001"
  resource_group_name = azurerm_resource_group.rg-test.name
  location            = azurerm_resource_group.rg-test.location
  address_space       = ["172.18.0.0/20"]
  provider            = azurerm.Test

}

resource "azurerm_subnet" "subnet-test" {
  name                 = "subnet-test-001"
  resource_group_name  = azurerm_resource_group.rg-test.name
  virtual_network_name = azurerm_virtual_network.spoke2.name
  address_prefixes     = ["172.18.1.0/24"]
  provider             = azurerm.Test
}

resource "azurerm_resource_group" "rg-uat" {
  name     = "rg-uat-network"
  location = "East US"
  provider = azurerm.UAT
}

resource "azurerm_virtual_network" "spoke3" {
  name                = "vnet-uat-spoke-001"
  resource_group_name = azurerm_resource_group.rg-uat.name
  location            = azurerm_resource_group.rg-uat.location
  address_space       = ["172.19.0.0/20"]
  provider            = azurerm.UAT

}

resource "azurerm_subnet" "subnet-uat" {
  name                 = "subnet-uat-001"
  resource_group_name  = azurerm_resource_group.rg-uat.name
  virtual_network_name = azurerm_virtual_network.spoke3.name
  address_prefixes     = ["172.19.1.0/24"]
  provider             = azurerm.UAT
}

resource "azurerm_virtual_network_peering" "hub_to_spoke1" {
  name                      = "hubToSpoke1"
  resource_group_name       = azurerm_resource_group.rg-hub.name
  virtual_network_name      = azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke1.id
  allow_forwarded_traffic   = true
  provider                  = azurerm.Prod
}

resource "azurerm_virtual_network_peering" "hub_to_spoke2" {
  name                      = "hubToSpoke2"
  resource_group_name       = azurerm_resource_group.rg-hub.name
  virtual_network_name      = azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke2.id
  allow_forwarded_traffic   = true
  provider                  = azurerm.Prod
}

resource "azurerm_virtual_network_peering" "hub_to_spoke3" {
  name                      = "hubToSpoke3"
  resource_group_name       = azurerm_resource_group.rg-hub.name
  virtual_network_name      = azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke3.id
  allow_forwarded_traffic   = true
  provider                  = azurerm.Prod
}

resource "azurerm_virtual_network_peering" "spoke1_to_hub" {
  name                      = "spoke1ToHub"
  resource_group_name       = azurerm_resource_group.rg-dev.name
  virtual_network_name      = azurerm_virtual_network.spoke1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-hub.id
  allow_forwarded_traffic   = true
  provider                  = azurerm.Dev
}

resource "azurerm_virtual_network_peering" "spoke2_to_hub" {
  name                      = "spoke2ToHub"
  resource_group_name       = azurerm_resource_group.rg-test.name
  virtual_network_name      = azurerm_virtual_network.spoke2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-hub.id
  allow_forwarded_traffic   = true
  provider                  = azurerm.Test
}

resource "azurerm_virtual_network_peering" "spoke3_to_hub" {
  name                      = "spoke3ToHub"
  resource_group_name       = azurerm_resource_group.rg-uat.name
  virtual_network_name      = azurerm_virtual_network.spoke3.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-hub.id
  allow_forwarded_traffic   = true
  provider                  = azurerm.UAT
}
