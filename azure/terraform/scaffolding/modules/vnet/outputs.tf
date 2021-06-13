output "default_nsg" {
  value = azurerm_network_security_group.default_nsg
}

output "vnet" {
  value = azurerm_virtual_network.vnet
}

# output "vnet_subnets" {    
#     value = azurerm_subnet.subnets   
# }
