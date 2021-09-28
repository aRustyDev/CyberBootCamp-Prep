# Load Balancer


# NICs
resource "azurerm_network_interface" "RedTeam_NIC_2" {
  name                = "RedTeam_NIC_2"
  location            = azurerm_resource_group.RedTeam_RG.location
  resource_group_name = azurerm_resource_group.RedTeam_RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.RedTeam_Subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "RedTeam_NIC_3" {
  name                = "RedTeam_NIC_3"
  location            = azurerm_resource_group.RedTeam_RG.location
  resource_group_name = azurerm_resource_group.RedTeam_RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.RedTeam_Subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual Machines
resource "azurerm_linux_virtual_machine" "web1" {
  name                = "Web-1"
  resource_group_name = azurerm_resource_group.RedTeam_RG.name
  location            = azurerm_resource_group.RedTeam_RG.location
  size                = "Standard_F2"
  admin_username      = local.default_user
  network_interface_ids = [
    azurerm_network_interface.RedTeam_NIC_2.id,
  ]

  admin_ssh_key {
    username   = var.default_user
    public_key = azurerm_ssh_public_key.RedTeam_SSH_jump.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "web2" {
  name                = "Web-2"
  resource_group_name = azurerm_resource_group.RedTeam_RG.name
  location            = azurerm_resource_group.RedTeam_RG.location
  size                = "Standard_F2"
  admin_username      = local.default_user
  network_interface_ids = [
    azurerm_network_interface.RedTeam_NIC_3.id,
  ]

  admin_ssh_key {
    username   = var.default_user
    public_key = azurerm_ssh_public_key.RedTeam_SSH_jump.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}