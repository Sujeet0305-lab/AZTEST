######################
## Network - Output ##
######################

output "network_resource_group_id" {
  value = "azurerm_resource_group.Demo1-AsiaPac-rg.id"
}

output "Public_Access_VNET_id" {
  value = azurerm_virtual_network.Public_Access_VNET.id
}

output "Public-subnet_id" {
  value = azurerm_subnet.Public-subnet.*.id
}

output "Common_Services_VNET_id" {
  value = azurerm_virtual_network.Common_Services_VNET.id
}

output "Common-subnet_id" {
  value = azurerm_subnet.Common-subnet.*.id
}

output "VDI_VNET_id" {
  value = azurerm_virtual_network.VDI_VNET.id
}

output "VDI-subnet_id" {
  value = azurerm_subnet.VDI-subnet.*.id
}

output "LAB_VNET_id" {
  value = azurerm_virtual_network.LAB_VNET.id
}

output "LAB-subnet_id" {
  value = azurerm_subnet.LAB-subnet.*.id
}