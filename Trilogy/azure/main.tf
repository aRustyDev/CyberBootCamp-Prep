# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Local Vars
locals {
  default_user = "adminuser"
  location = "East US"
}

# Create a resource group
resource "azurerm_resource_group" "RedTeam_RG" {
  name     = "RedTeam_RG"
  location = local.location
}

resource "azurerm_ssh_public_key" "RedTeam_SSH_jump" {
  name                = "RedTeam-SSH-jump"
  resource_group_name = azurerm_resource_group.RedTeam_RG.name
  location            = azurerm_resource_group.RedTeam_RG.location
  public_key          = file("C:/users/aRustyDev.ARUSTY/.ssh/id_rsa.pub")
}

resource "azurerm_ssh_public_key" "RedTeam_SSH_web" {
  name                = "RedTeam-SSH-web"
  resource_group_name = azurerm_resource_group.RedTeam_RG.name
  location            = azurerm_resource_group.RedTeam_RG.location
  public_key          = file("C:/users/aRustyDev.ARUSTY/.ssh/id_rsa.pub")
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "RedTeam_Network" {
  name                = "RedTeam_Network"
  resource_group_name = azurerm_resource_group.RedTeam_RG.name
  location            = azurerm_resource_group.RedTeam_RG.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_availability_set" "RedTeam_AS" {
  name                = "RedTeam_AS"
  location            = azurerm_resource_group.RedTeam_RG.location
  resource_group_name = azurerm_resource_group.RedTeam_RG.name
}

resource "azurerm_subnet" "RedTeam_Subnet" {
  name                 = "RedTeam_Subnet"
  resource_group_name  = azurerm_resource_group.RedTeam_RG.name
  virtual_network_name = azurerm_virtual_network.RedTeam_Network.name
  address_prefixes     = ["10.0.2.0/24"]
}