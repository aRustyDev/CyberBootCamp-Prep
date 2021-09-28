resource "azurerm_network_security_group" "RedTeam_NSG" {
  name                = "RedTeam_NSG"
  location            = azurerm_resource_group.RedTeam_RG.location
  resource_group_name = azurerm_resource_group.RedTeam_RG.name
  
  security_rule {
    name                       = "Allow_SSH_frHome"
    priority                   = 100
    description                = ""
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = chomp(data.http.myip.body)
    destination_address_prefix = chomp(azurerm_public_ip.RedTeam_JumpBox_IP.ip_address)
  }

  security_rule {
    name                       = "Allow_HTTP_frHome"
    priority                   = 101
    description                = ""
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = chomp(data.http.myip.body)
    destination_address_prefix = "*"
  }
  
  security_rule {
    name                       = "Allow_Mgmt_frHome"
    priority                   = 102
    description                = ""
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.0.0/16"
    destination_address_prefix = "10.0.0.0/16"
  }
}
resource "azurerm_subnet_network_security_group_association" "RedTeam_NSG" {
  subnet_id                 = azurerm_subnet.RedTeam_Subnet.id
  network_security_group_id = azurerm_network_security_group.RedTeam_NSG.id
}