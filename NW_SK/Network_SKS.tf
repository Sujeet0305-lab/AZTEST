# configure backend to keep terraform state
terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform-States"
    storage_account_name = "terraformstate646"
    container_name       = "terraformstate-tst"
    key                  = "Dev.terraform.tfstate"
	access_key = "9cSLNVNaOTy3FK5RNjrOHynvw940gmfKsNv0EXa685KYaMWRPzxcFGvliyCiR5Z+Aru8adC+QfySWWDQ8EdbXA=="
#	subscription_id = "049b4809-15cc-4329-9293-86fb9830d679"
#    tenant_id       = "2a6e7c50-7422-4392-a932-3e5fa8eccf33"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
#skip_provider_registration = "true"
      version = "2.6.0"
    features {}

  subscription_id = "049b4809-15cc-4329-9293-86fb9830d679"
  tenant_id       = "2a6e7c50-7422-4392-a932-3e5fa8eccf33"
  client_id       = "d3d9508d-5f3f-404d-9f9a-29cca7c2a06e"
  client_secret   = "0%7O([!S4=x\\|sZIeE>=h?/SbeRJx$?="

}

####################
## Network - Main ##
####################

# Create a resource group for network
resource "azurerm_resource_group" "Demo1-AsiaPac-rg" {
 name     = "asiapac-sandbox_Demo"
  location = "centralindia"
}

# Create the network Public_Access VNET
resource "azurerm_virtual_network" "Public_Access_VNET" {
  name                = "AsiapacPublicNetwork1"
  address_space       = ["${var.vnet_address_space}"]
  location            = "azurerm_resource_group.Demo1-AsiaPac-rg.location"
  resource_group_name = "azurerm_resource_group.Demo1-AsiaPac-rg.name"
}


# Create a subnet for Network

resource "azurerm_subnet" "Public-subnet" {
  count                = length(var.subnet_prefix)
  name                 = "Publicsubnet-${count.index}"
  resource_group_name  = "azurerm_resource_group.Demo1-AsiaPac-rg.name"
  virtual_network_name = "azurerm_virtual_network.Public_Access_VNET.name"
  address_prefix       = element(var.subnet_prefix, count.index)
}

# Create the network Common Services VNET VNET
resource "azurerm_virtual_network" "Common_Services_VNET" {
  name                = "AsiapacCommonServicesNetwork1"
  address_space       = ["${var.vnet_address_space_Common}"]
  location            = "azurerm_resource_group.Demo1-AsiaPac-rg.location"
  resource_group_name = "azurerm_resource_group.Demo1-AsiaPac-rg.name"
}

# Create a Common Services subnet for Network

resource "azurerm_subnet" "Common-subnet" {
  count                = length(var.subnet_prefix_Common)
  name                 = "Commonsubnet-${count.index}"
  resource_group_name  = "azurerm_resource_group.Demo1-AsiaPac-rg.name"
  virtual_network_name = "azurerm_virtual_network.Common_Services_VNET.name"
  address_prefix       = element(var.subnet_prefix_Common, count.index)
}

# Create the network VDI VNET
resource "azurerm_virtual_network" "VDI_VNET" {
  name                = "AsiapacVDINetwork1"
  address_space       = ["${var.vnet_address_space_VDI}"]
  location            = "azurerm_resource_group.Demo1-AsiaPac-rg.location"
  resource_group_name = "azurerm_resource_group.Demo1-AsiaPac-rg.name"
}

# Create a VDI subnet for Network

resource "azurerm_subnet" "VDI-subnet" {
  count                = length(var.subnet_prefix_VDI)
  name                 = "VDIsubnet-${count.index}"
  resource_group_name  = "azurerm_resource_group.Demo1-AsiaPac-rg.name"
  virtual_network_name = "azurerm_virtual_network.VDI_VNET.name"
  address_prefix       = element(var.subnet_prefix_VDI, count.index)
}


# Create the network LAB VNET
resource "azurerm_virtual_network" "LAB_VNET" {
  name                = "AsiapacLABNetwork1"
  address_space       = ["${var.vnet_address_space_LAB}"]
  location            = "azurerm_resource_group.Demo1-AsiaPac-rg.location"
  resource_group_name = "azurerm_resource_group.Demo1-AsiaPac-rg.name"
}

# Create a LAB subnet for Network

resource "azurerm_subnet" "LAB-subnet" {
  count                = length(var.subnet_prefix_LAB)
  name                 = "VDIsubnet-${count.index}"
  resource_group_name  = "azurerm_resource_group.Demo1-AsiaPac-rg.name"
  virtual_network_name = "azurerm_virtual_network.LAB_VNET.name"
  address_prefix       = element(var.subnet_prefix_LAB, count.index)
}


resource "azurerm_virtual_network_peering" "Public-peer-Common" {
  name                      = "Public_to_Common_Peer"
  resource_group_name       = "azurerm_resource_group.Demo-AsiaPac-rg.name"
  virtual_network_name      = "azurerm_virtual_network.Public_Access_VNET.name"
  remote_virtual_network_id = "azurerm_virtual_network.Common_Services_VNET.id"
  allow_virtual_network_access = true
  depends_on                = [azurerm_subnet.Public-subnet]
}

resource "azurerm_virtual_network_peering" "Common-peer-Public" {
  name                      = "Common_to_Public_Peer"
  resource_group_name       = "azurerm_resource_group.Demo-AsiaPac-rg.name"
  virtual_network_name      = "azurerm_virtual_network.Common_Services_VNET.name"
  remote_virtual_network_id = "azurerm_virtual_network.Public_Access_VNET.id"
  allow_virtual_network_access = true
  depends_on                = [azurerm_subnet.Public-subnet]
}
