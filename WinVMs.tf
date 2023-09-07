

# Resource group for Prod
resource "azurerm_resource_group" "rg_prod" {
  name     = "rg-prod-vms"
  location = "East US"
  provider = azurerm.Prod
}

# Network Interface for Prod VM
resource "azurerm_network_interface" "nic_prod" {
  name                = "vnic-prod-vm"
  location            = azurerm_resource_group.rg_prod.location
  resource_group_name = azurerm_resource_group.rg_prod.name
  provider            = azurerm.Prod

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/6ff1da01-3b3d-4db3-bd6e-b5fc68561c96/resourceGroups/rg-prod-hub-network/providers/Microsoft.Network/virtualNetworks/vnet-hub/subnets/subnet-hub"
    private_ip_address_allocation = "Dynamic"
  }
}

# Windows 10 VM for Prod
resource "azurerm_windows_virtual_machine" "vm_prod" {
  name                = "vm-prod"
  location            = azurerm_resource_group.rg_prod.location
  resource_group_name = azurerm_resource_group.rg_prod.name
  size                = "Standard_D2s_v3"
  provider            = azurerm.Prod

  network_interface_ids = [azurerm_network_interface.nic_prod.id]

  admin_username = "nickroadmin"
  admin_password = "Voyage-Cable-Unengaged4"


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "21h1-pro"
    version   = "latest"
  }
}

# Resource group for Dev
resource "azurerm_resource_group" "rg_dev" {
  name     = "rg-dev-vms"
  location = "East US"
  provider = azurerm.Dev
}

# Network Interface for Dev VM
resource "azurerm_network_interface" "nic_dev" {
  name                = "vnic-dev-vm"
  location            = azurerm_resource_group.rg_dev.location
  resource_group_name = azurerm_resource_group.rg_dev.name
  provider            = azurerm.Dev

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/960edb14-5680-4e2d-9dd0-d9572040ae41/resourceGroups/rg-dev-network/providers/Microsoft.Network/virtualNetworks/vnet-dev-spoke-001/subnets/subnet-dev-001"
    private_ip_address_allocation = "Dynamic"
  }
}

# Windows 10 VM for Dev
resource "azurerm_windows_virtual_machine" "vm_dev" {
  name                = "vm-dev"
  location            = azurerm_resource_group.rg_dev.location
  resource_group_name = azurerm_resource_group.rg_dev.name
  size                = "Standard_D2s_v3"
  provider            = azurerm.Dev

  network_interface_ids = [azurerm_network_interface.nic_dev.id]

  admin_username = "nickroadmin"
  admin_password = "Voyage-Cable-Unengaged4"


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "21h1-pro"
    version   = "latest"
  }
}

# Resource group for Test
resource "azurerm_resource_group" "rg_test" {
  name     = "rg-test-vms"
  location = "East US"
  provider = azurerm.Test
}

# Network Interface for Test VM
resource "azurerm_network_interface" "nic_test" {
  name                = "vnic-test-vm"
  location            = azurerm_resource_group.rg_test.location
  resource_group_name = azurerm_resource_group.rg_test.name
  provider            = azurerm.Test

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/d5564584-9e08-45cc-a2ff-e951ff6688cc/resourceGroups/rg-test-network/providers/Microsoft.Network/virtualNetworks/vnet-test-spoke-001/subnets/subnet-test-001"
    private_ip_address_allocation = "Dynamic"
  }
}

# Windows 10 VM for Test
resource "azurerm_windows_virtual_machine" "vm_test" {
  name                = "vm-test"
  location            = azurerm_resource_group.rg_test.location
  resource_group_name = azurerm_resource_group.rg_test.name
  size                = "Standard_D2s_v3"
  provider            = azurerm.Test

  network_interface_ids = [azurerm_network_interface.nic_test.id]

  admin_username = "nickroadmin"
  admin_password = "Voyage-Cable-Unengaged4"


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "21h1-pro"
    version   = "latest"
  }
}

# Resource group for UAT
resource "azurerm_resource_group" "rg_uat" {
  name     = "rg-uat-vms"
  location = "East US"
  provider = azurerm.UAT
}

# Network Interface for UAT VM
resource "azurerm_network_interface" "nic_uat" {
  name                = "vnic-uat-vm"
  location            = azurerm_resource_group.rg_uat.location
  resource_group_name = azurerm_resource_group.rg_uat.name
  provider            = azurerm.UAT

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/7d46ecfe-2287-4bce-98af-2e8fdf0dbaa9/resourceGroups/rg-uat-network/providers/Microsoft.Network/virtualNetworks/vnet-uat-spoke-001/subnets/subnet-uat-001"
    private_ip_address_allocation = "Dynamic"
  }
}

# Windows 10 VM for UAT
resource "azurerm_windows_virtual_machine" "vm_uat" {
  name                = "vm-uat"
  location            = azurerm_resource_group.rg_uat.location
  resource_group_name = azurerm_resource_group.rg_uat.name
  size                = "Standard_D2s_v3"
  provider            = azurerm.UAT

  network_interface_ids = [azurerm_network_interface.nic_uat.id]

  admin_username = "nickroadmin"
  admin_password = "Voyage-Cable-Unengaged4"


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "21h1-pro"
    version   = "latest"
  }
}