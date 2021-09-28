resource "azurerm_public_ip" "RedTeam_JumpBox_IP" {
  name                = "RedTeam_IP"
  resource_group_name = azurerm_resource_group.RedTeam_RG.name
  location            = azurerm_resource_group.RedTeam_RG.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "RedTeam_NIC_1" {
  name                = "RedTeam_NIC_1"
  location            = azurerm_resource_group.RedTeam_RG.location
  resource_group_name = azurerm_resource_group.RedTeam_RG.name

  ip_configuration {
    name                          = "External"
    subnet_id                     = azurerm_subnet.RedTeam_Subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.RedTeam_JumpBox_IP.id
  }
}

resource "azurerm_linux_virtual_machine" "JumpBox" {
  name                = "JumpBox"
  resource_group_name = azurerm_resource_group.RedTeam_RG.name
  location            = azurerm_resource_group.RedTeam_RG.location
  size                = "Standard_F2"
  admin_username      = local.default_user
  network_interface_ids = [
    azurerm_network_interface.RedTeam_NIC_1.id,
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